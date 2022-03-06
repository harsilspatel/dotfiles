local hotkeyextension = {}
local log = require('hs.logger').new('hotkeyextension', 'info')
hotkeyextension.setLogLevel = log.setLogLevel
hotkeyextension.getLogLevel = log.getLogLevel

-- from skhd
local MODIFIER_FLAGS = {
  lalt = 0x00000020,
  ralt = 0x00000040,
  lshift = 0x00000002,
  rshift = 0x00000004,
  lcmd = 0x00000008,
  rcmd = 0x00000010,
  lctrl = 0x00000001,
  rctrl = 0x00002000
}

local bindings = {}
local enabledHotkeys = 0

--- Parameters:
---  * modifierFlags - flags OR'ed from eventtap data for e.g 1573192
--- Returns:
---  * An array-like table of modifiers for e.g {'lcmd', 'ralt'}
local function getModifierNames(modifierFlags)
  local names = {}
  for keyname, flag in pairs(MODIFIER_FLAGS) do
    if (modifierFlags & tonumber(flag) > 0) then table.insert(names, keyname) end
  end
  return names
end

local function addModifierToAllCombinations(combinations, modifierName)
  return hs.fnutils.imap(combinations, function(combination)
    table.insert(combination, modifierName) -- mutates combination i.e. doesn't return anything
    return combination
  end)
end

--- Parameters:
---  * hotkeyModifierNames - modifiers to bind hotkey for e.g {'cmd', 'alt'}
--- Returns:
---  * A table of tables for all possible combinations of those modifiers, for given input result will be:
---  {{'lcmd', 'lalt'}, {'lcmd', 'ralt'}, {'rcmd', 'lalt'}, {'rcmd', 'ralt'}}
local function getAllModifierCombinations(hotkeyModifierNames)
  local combinations = {{}}

  for _, modifierName in ipairs(hotkeyModifierNames) do
    local leftModifier = 'l' .. modifierName
    local rightModifier = 'r' .. modifierName
    local isCommonModifier = MODIFIER_FLAGS[leftModifier] and MODIFIER_FLAGS[rightModifier]
    if isCommonModifier then
      local combinationsClone = hs.fnutils.imap(combinations,
        function(combination) return {table.unpack(combination)} end)
      combinationsClone = addModifierToAllCombinations(combinationsClone, leftModifier)

      combinations = addModifierToAllCombinations(combinations, rightModifier)
      combinations = hs.fnutils.concat(combinations, combinationsClone)
    else
      combinations = addModifierToAllCombinations(combinations, modifierName)
    end

  end

  return combinations
end

--- Parameters:
---  * mods - A table or a string containing the keyboard modifiers required,
---    which should be zero or more of the following:
---    * "cmd", "lcmd" or "rcmd"
---    * "ctrl", "lctrl" or "rctrl"
---    * "alt", "lalt" or "ralt"
---    * "shift", "lshift" or "rshift"
---  * key - A string containing the name of a keyboard key
--- Returns:
---  Returns a string of concetanated modifiers and key for e.g `lcmd.ralt.h`
local function generateHotkeyHash(modifiers, key)
  -- sorting combinations so "hash" is deterministic
  local modifiersCopy = hs.fnutils.copy(modifiers)
  table.sort(modifiersCopy)
  table.insert(modifiersCopy, key)
  return table.concat(modifiersCopy, '.')
end

local keyDownEventTap = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp},
  function(event)
    local eventData = event:getRawEventData()['NSEventData']

    local modifierFlags = eventData.modifierFlags
    local eventModifiers = getModifierNames(modifierFlags)
    if #eventModifiers == 0 then return end

    local keyCode = eventData.keyCode
    local keyName = hs.keycodes.map[keyCode]

    -- TODO(harsilspatel): LRU cache some values
    local eventHotkeyHash = generateHotkeyHash(eventModifiers, keyName)
    if not bindings[eventHotkeyHash] then return end

    local isKeyDown = event:getType() == hs.eventtap.event.types.keyDown
    local isRepeat = event:getProperty(hs.eventtap.event.properties['keyboardEventAutorepeat']) > 0

    local fnType
    if isRepeat then
      fnType = 'repeatfn'
    elseif isKeyDown then
      fnType = 'pressedfn'
    else
      fnType = 'releasedfn'
    end

    local fn = bindings[eventHotkeyHash][fnType]
    if not fn then return end

    fn(eventData)
    return true
  end)

local function enable(self)
  if (self.enabled) then
    log.v('Hotkey already enabled')
    return self
  end

  self.enable = true
  enabledHotkeys = enabledHotkeys + 1
  if (not keyDownEventTap:isEnabled() and enabledHotkeys > 0) then keyDownEventTap:start() end

  return self
end

local function disable(self)
  if not self.enabled then
    log.v('Hotkey already disabled')
    return self
  end

  self.enable = false
  enabledHotkeys = enabledHotkeys - 1
  if (keyDownEventTap:isEnabled() and enabledHotkeys == 0) then keyDownEventTap:stop() end

  return self
end

local function delete(self)
  disable(self)

  hs.fnutils.ieach(self.hotkeyHashes, function(hotkeyHash)
    if bindings[hotkeyHash] == nil then log.ef('Hotkey %s is already deleted', hotkeyHash) end

    bindings[hotkeyHash] = nil
    log.f('Deleted hotkey %s', hotkeyHash)
  end)
end

--- Parameters:
---  * mods - A table or a string containing the keyboard modifiers required,
---    which should be zero or more of the following:
---    * "cmd", "lcmd" or "rcmd"
---    * "ctrl", "lctrl" or "rctrl"
---    * "alt", "lalt" or "ralt"
---    * "shift", "lshift" or "rshift"
---  * key - A string containing the name of a keyboard key
---  * pressedfn - A function that will be called when the hotkey has been pressed
--- Returns:
---  * None
function hotkeyextension.new(mods, key, pressedfn, releasedfn, repeatfn)
  if not pressedfn and not releasedfn and not repeatfn then
    error('At least one of pressedfn, releasedfn or repeatfn must be a present', 2)
  end

  local combinations = getAllModifierCombinations(mods)
  local hotkeyHashes = hs.fnutils.imap(combinations,
    function(combination) return generateHotkeyHash(combination, key) end)

  local hk = {
    pressedfn = pressedfn,
    releasedfn = releasedfn,
    repeatfn = repeatfn,

    delete = delete,
    enable = enable,
    disable = disable,

    enabled = false,
    hotkeyHashes = hotkeyHashes
  }

  hs.fnutils.ieach(hotkeyHashes, function(hotkeyHash)
    if bindings[hotkeyHash] ~= nil then error('Hotkey ' .. hotkeyHash .. ' is already binded', 2) end

    bindings[hotkeyHash] = hk
    log.f('Enabled hotkey %s', hotkeyHash)
  end)

  return hk
end

function hotkeyextension.bind(...) return hotkeyextension.new(...):enable() end

hs.hotkeyextension = hotkeyextension
return hotkeyextension

