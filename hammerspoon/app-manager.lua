
function launchOrFocus(app)
  return function () hs.application.launchOrFocus(app) end
end

local appManagerModifiers = {'ralt'}

hs.hotkeyextension.bind(appManagerModifiers, 'r', launchOrFocus('System Preferences'))

hs.hotkeyextension.bind(appManagerModifiers, 'a', launchOrFocus('Authy Desktop'))
hs.hotkeyextension.bind(appManagerModifiers, 's', function () hs.osascript.applescript('tell application "/Applications/Google Chrome.app"\nmake new window\nactivate\nend tell') end)
hs.hotkeyextension.bind(appManagerModifiers, 'd', launchOrFocus('Slack'))
hs.hotkeyextension.bind(appManagerModifiers, 'f', launchOrFocus('Spotify'))

hs.hotkeyextension.bind(appManagerModifiers, 'b', launchOrFocus('BetterTouchTool'))
