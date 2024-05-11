function launchOrFocus(app) return function() hs.application.launchOrFocus(app) end end

local appManagerModifiers = {'ralt'}

hs.hotkeyextension.bind(appManagerModifiers, 'w', launchOrFocus('Whatsapp'))
hs.hotkeyextension.bind(appManagerModifiers, 'r', launchOrFocus('System Preferences'))
hs.hotkeyextension.bind(appManagerModifiers, 'o', launchOrFocus('Obsidian'))

hs.hotkeyextension.bind(appManagerModifiers, 'a', launchOrFocus('Authy Desktop'))
hs.hotkeyextension.bind(appManagerModifiers, 's', function()
  hs.osascript.applescript('tell application "System Events"\n\ttell process "Google Chrome"\n\t\tclick menu item "New Window" of menu "File" of menu bar 1\n\tend tell\nend tell')
end)
hs.hotkeyextension.bind(appManagerModifiers, 'd', launchOrFocus('Slack'))
hs.hotkeyextension.bind(appManagerModifiers, 'f', launchOrFocus('Spotify'))

hs.hotkeyextension.bind(appManagerModifiers, 'h', launchOrFocus('Hammerspoon'))

hs.hotkeyextension.bind(appManagerModifiers, 'l', launchOrFocus('Linear'))

hs.hotkeyextension.bind(appManagerModifiers, 'b', launchOrFocus('BetterTouchTool'))
hs.hotkeyextension.bind(appManagerModifiers, 'n', launchOrFocus('Notes'))
hs.hotkeyextension.bind(appManagerModifiers, 'm', launchOrFocus('Activity Manager'))

hs.hotkeyextension.bind(appManagerModifiers, '`', function() hs.caffeinate.lockScreen() end)
