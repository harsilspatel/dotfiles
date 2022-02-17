local function sendSystemKey(key)
  return function()
    hs.eventtap.event.newSystemKeyEvent(key, true):post()
    hs.eventtap.event.newSystemKeyEvent(key, false):post()
  end
end

local mediaManagerModifiers = {'rcmd'}

hs.hotkeyextension.bind(mediaManagerModifiers, 'q', sendSystemKey("PREVIOUS"))
hs.hotkeyextension.bind(mediaManagerModifiers, 'w', sendSystemKey("PLAY"))
hs.hotkeyextension.bind(mediaManagerModifiers, 'e', sendSystemKey("NEXT"))


hs.hotkeyextension.bind(mediaManagerModifiers, 'z', sendSystemKey("MUTE"))
hs.hotkeyextension.bind(mediaManagerModifiers, 'x', sendSystemKey("SOUND_DOWN"))
hs.hotkeyextension.bind(mediaManagerModifiers, 'c', sendSystemKey("SOUND_UP"))
