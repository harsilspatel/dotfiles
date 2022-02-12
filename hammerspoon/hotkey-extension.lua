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
  local flags = {}
  for keyname, flag in pairs(MODIFIER_FLAGS) do if (modifierFlags & tonumber(flag) > 0) then flags[keyname] = true end end
  print('flags', dump(flags))
  return flags
end

local function compareModifiers(hotkeyModifierNames, eventModifierFlags)
  -- hotkeyModifiers will be table of strings for e.g {'ralt', 'lcmd'}
  -- eventModifierFlags will be an integer for e.g 524608 (i.e 'ralt')
  local eventModifierNamesMap = getModifierNames(eventModifierFlags)
  print('xxxxxxxxxxxxxx', dump(hotkeyModifierNames), dump(eventModifierNamesMap))
  for _, modifier in ipairs(hotkeyModifierNames) do
    local leftModifier = 'l' .. modifier
    local rightModifier = 'r' .. modifier

    local isModifierPressed = eventModifierNamesMap[modifier] or eventModifierNamesMap[leftModifier] or
                                eventModifierNamesMap[rightModifier]
    print('yyyy', modifier, isModifierPressed)
    if (not isModifierPressed) then return false end
  end
  return true
end

local keyDown = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
  local eventData = event:getRawEventData()['NSEventData']
  local keyCode = eventData.keyCode
  local modifierFlags = eventData.modifierFlags

  for _, binding in ipairs(bindings) do
    local key = binding.key
    local mods = binding.mods
    -- local pressedFn = binding.pressedFn
    if (key == hs.keycodes.map[keyCode] and compareModifiers(mods, modifierFlags)) then
      binding.pressedFn()
      return true
    end
  end

  print(dump(bindings))
  -- getModifierNames(modifierFlags)
  -- if (hs.keycodes.map[keyCode] == key and modifierFlags == 524608) then hs.application.launchOrFocus('Slack') end
end)

local module = {}

function module.bind(mods, key, pressedFn)
  -- if (not bindings[key]) then bindings[key] = {} end
  -- local keyTable = bindings[key]
  -- keyTable[#keyTable + 1] = {mods = mods, pressedFn = pressedFn}
  bindings[#bindings + 1] = {mods = mods, key = key, pressedFn = pressedFn}

  if (not keyDown:isEnabled()) then keyDown:start() end
end

hs.hotkeyextension = module
return (module)
