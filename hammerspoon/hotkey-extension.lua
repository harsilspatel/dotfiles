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
  table.sort(modifiers)
  table.insert(modifiers, key)
  return table.concat(modifiers, '.')
end

local keyDownEventTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
  local eventData = event:getRawEventData()['NSEventData']

  local keyCode = eventData.keyCode
  local keyName = hs.keycodes.map[keyCode]

  local modifierFlags = eventData.modifierFlags
  local eventModifiers = getModifierNames(modifierFlags)

  local eventHotkeyHash = generateHotkeyHash(eventModifiers, keyName)

  if #eventModifiers == 0 or (#eventModifiers == 1 and hs.fnutils.contains({'lcmd', 'rcmd'}, eventModifiers[1])) then
    return
  elseif (bindings[eventHotkeyHash]) then
    local pressedFn = bindings[eventHotkeyHash]
    pressedFn(eventData)
    return true
  end
end)

local module = {}

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
function module.bind(mods, key, pressedFn)
  local combinations = getAllModifierCombinations(mods)
  local hotkeyHashes = hs.fnutils.imap(combinations,
    function(combination) return generateHotkeyHash(combination, key) end)

  hs.fnutils.ieach(hotkeyHashes, function(hotkeyHash) bindings[hotkeyHash] = pressedFn end)

  if (not keyDownEventTap:isEnabled()) then keyDownEventTap:start() end
end

hs.hotkeyextension = module
return (module)
