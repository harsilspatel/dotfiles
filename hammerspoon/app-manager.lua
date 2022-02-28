function launchOrFocus(app) return function() hs.application.launchOrFocus(app) end end

local appManagerModifiers = { 'ralt' }

hs.hotkeyextension.bind(appManagerModifiers, 'r', launchOrFocus('System Preferences'))

hs.hotkeyextension.bind(appManagerModifiers, 'a', launchOrFocus('Authy Desktop'))
hs.hotkeyextension.bind(appManagerModifiers, 's', function() hs.osascript.applescript('tell application "/Applications/Google Chrome.app"\nmake new window\nactivate\nend tell') end)
hs.hotkeyextension.bind(appManagerModifiers, 'd', launchOrFocus('Slack'))
hs.hotkeyextension.bind(appManagerModifiers, 'f', launchOrFocus('Spotify'))

hs.hotkeyextension.bind(appManagerModifiers, 'h', launchOrFocus('Hammerspoon'))

hs.hotkeyextension.bind(appManagerModifiers, 'b', launchOrFocus('BetterTouchTool'))

local UI = require('rb.ui')
local ax = require('hs.axuielement')

local function focusDock() UI.getUIElement(hs.application('Dock'), { { 'AXList', 1 } }):setAttributeValue('AXFocused', true) end

local function focusMenuBar() ax.systemElementAtPosition({ 0, 0 }):attributeValue('AXParent')[2]:performAction('AXPress') end

hs.hotkeyextension.bind(appManagerModifiers, ',', focusMenuBar)
hs.hotkeyextension.bind(appManagerModifiers, '.', focusDock)
