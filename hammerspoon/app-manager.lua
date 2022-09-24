function launchOrFocus(app) return function() hs.application.launchOrFocus(app) end end

local appManagerModifiers = {'ralt'}

hs.hotkeyextension.bind(appManagerModifiers, 'r', launchOrFocus('System Preferences'))

hs.hotkeyextension.bind(appManagerModifiers, 'a', launchOrFocus('Authy Desktop'))
hs.hotkeyextension.bind(appManagerModifiers, 's', function()
  hs.osascript.applescript('tell application "/Applications/Google Chrome.app"\nmake new window with properties {mode: "normal"}\nactivate\nend tell')
end)
hs.hotkeyextension.bind(appManagerModifiers, 'd', launchOrFocus('Slack'))
hs.hotkeyextension.bind(appManagerModifiers, 'f', launchOrFocus('Spotify'))

hs.hotkeyextension.bind(appManagerModifiers, 'h', launchOrFocus('Hammerspoon'))

hs.hotkeyextension.bind(appManagerModifiers, 'b', launchOrFocus('BetterTouchTool'))

-- when we import rb.ui, it then tries to import it's sibling file utils.lua by
-- importing rb.utils and local since it's not in path it seems to can't find it
-- source: https://stackoverflow.com/a/9145447/9701238
package.path = './modules/roeybiran/?.lua;' .. package.path
local UI = require('modules.roeybiran.rb.ui')
local ax = require('hs.axuielement')

local function focusDock() UI.getUIElement(hs.application('Dock'), {{'AXList', 1}}):setAttributeValue('AXFocused', true) end

local function focusMenuBar() ax.systemElementAtPosition({0, 0}):attributeValue('AXParent')[2]:performAction('AXPress') end

hs.hotkeyextension.bind(appManagerModifiers, ',', focusMenuBar)
hs.hotkeyextension.bind(appManagerModifiers, '.', focusDock)
hs.hotkeyextension.bind(appManagerModifiers, '`', function() hs.caffeinate.lockScreen() end)
