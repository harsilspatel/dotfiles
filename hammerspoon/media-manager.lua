-- there's this weird issue where sound output unbalances itself
-- apparently hs.timer.doEvery() doesn't work ¯\_(ツ)_/¯
hs.timer.doWhile(function() return true end, function()
  if (hs.audiodevice.current().device:balance() ~= 0.5) then hs.audiodevice.current().device:setBalance(0.5) end
end, 10)

local function sendSystemKey(key)
  return function()
    hs.eventtap.event.newSystemKeyEvent(key, true):post()
    hs.eventtap.event.newSystemKeyEvent(key, false):post()
  end
end

local function seekAudio(direction)
  return function()
    hs.osascript.applescript(
      'set appName to "VLC"\nif application appName is running then\ntell application "VLC" to step ' .. direction ..
        '\nend if\nend')
  end
end

local mediaManagerModifiers = {'rcmd'}

hs.hotkeyextension.bind(mediaManagerModifiers, 'q', sendSystemKey('PREVIOUS'))
hs.hotkeyextension.bind(mediaManagerModifiers, 'w', sendSystemKey('PLAY'))
hs.hotkeyextension.bind(mediaManagerModifiers, 'e', sendSystemKey('NEXT'))

hs.hotkeyextension.bind(mediaManagerModifiers, 'a', seekAudio('backward'))
hs.hotkeyextension.bind(mediaManagerModifiers, 's', seekAudio('forward'))

hs.hotkeyextension.bind(mediaManagerModifiers, 'z', sendSystemKey('MUTE'))
hs.hotkeyextension.bind(mediaManagerModifiers, 'x', sendSystemKey('SOUND_DOWN'))
hs.hotkeyextension.bind(mediaManagerModifiers, 'c', sendSystemKey('SOUND_UP'))
