local MODIFIER_FLAGS = {
  -- alt = 0x00080000,
  lalt = 0x00000020,
  ralt = 0x00000040,
  -- shift = 0x00020000,
  lshift = 0x00000002,
  rshift = 0x00000004,
  -- cmd = 0x00100000,
  lcmd = 0x00000008,
  rcmd = 0x00000010,
  -- control = 0x00040000,
  lcontrol = 0x00000001,
  rcontrol = 0x00002000
  -- fn = 0x00800000
}

local bindings = {}

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

local function getHotkeyHash(modifiers, key)
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

  p(eventModifiers)
  local eventHotkeyHash = getHotkeyHash(eventModifiers, keyName)
  print('yo', eventHotkeyHash)
  print('pressedFn', bindings[eventHotkeyHash])

  if #eventModifiers == 0 or (#eventModifiers == 1 and hs.fnutils.contains({'lcmd', 'rcmd'}, eventModifiers[1])) then
    return
  elseif (bindings[eventHotkeyHash]) then
    local pressedFn = bindings[eventHotkeyHash]
    pressedFn(eventData)
    return true
  end

  -- print(dump(bindings))
  -- getModifierNames(modifierFlags)
  -- if (hs.keycodes.map[keyCode] == key and modifierFlags == 524608) then hs.application.launchOrFocus('Slack') end
end)

local module = {}

function module.bind(mods, key, pressedFn)
  -- if (not bindings[key]) then bindings[key] = {} end
  -- local keyTable = bindings[key]
  -- keyTable[#keyTable + 1] = {mods = mods, pressedFn = pressedFn}

  local combinations = getAllModifierCombinations(mods)
  local hotkeyHashes = hs.fnutils.imap(combinations, function(combination) return getHotkeyHash(combination, key) end)

  hs.fnutils.ieach(hotkeyHashes, function(hotkeyHash) bindings[hotkeyHash] = pressedFn end)
  print('dssfasdfasdfa', p(bindings))

  -- print('hotkeyHashes', dump(hotkeyHashes))

  -- bindings[#bindings + 1] = {mods = mods, key = key, pressedFn = pressedFn}

  if (not keyDownEventTap:isEnabled()) then keyDownEventTap:start() end
end

hs.hotkeyextension = module
return (module)
