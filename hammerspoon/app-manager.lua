-- local modifiers = 'rightoption'
-- local mapping = {['c'] = 'Slack'}
-- local hkey = require('hkey')
-- spy = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
--   print(string.gsub(hs.inspect(event:getFlags()), '\n *', '') .. ' ' .. hs.keycodes.map[event:getKeyCode()])
-- end):start()
-- print('modifiers==========', dump(getMods({'cmddd'})), hs.libhotkey)
-- for key, app in pairs(mapping) do hs.hotkey.bind(modifiers, key, function() hs.application.launchOrFocus(app) end) end
-- hs.hotkey.bind('option', 'd', function() hs.application.launchOrFocus('Slack') end)
-- hs.hotkey.bind('option', 'n', function() hs.application.launchOrFocus('Slack') end)
-- hs.hotkey.bind('rightshift', 'x', function() print("======================================= rightshift C") end)
hs.hotkeyextension.bind({'ralt'}, 'd', function() hs.application.launchOrFocus('Slack') end)
hs.hotkeyextension.bind({'ralt'}, 'f', function() hs.application.launchOrFocus('Spotify') end)
hs.hotkeyextension.bind({'ralt'}, 'a', function() hs.application.launchOrFocus('Authy Desktop') end)
