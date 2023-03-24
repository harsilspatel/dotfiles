-- disable animations
hs.window.animationDuration = 0

-- focus windows by direction (like tmux)
-- yanked from https://gist.github.com/mtchllbrrn/efb5baabbafb8742fd52c826269dbdf0
local function focus(direction)
  local focusWindowFunction = 'focusWindow' .. (direction:gsub('^%l', string.upper))

  return function()
    local window = hs.window.focusedWindow()
    if not window then return end

    window[focusWindowFunction]()
  end
end

local function focus_window_under_mouse()
  -- yanked from https://gist.github.com/kizzx2/e542fa74b80b7563045a#gistcomment-3121012
  local position = hs.geometry.new(hs.mouse.absolutePosition())
  local screen = hs.mouse.getCurrentScreen()

  local window = hs.fnutils.find(hs.window.orderedWindows(),
    function(w) return screen == w:screen() and position:inside(w:frame()) end)

  if not window then return end
  window:focus()
end

local function resize_focussed_window(screenProportion)
  return function()
    local window = hs.window.focusedWindow()
    if not window then return end

    local screen = window:screen()
    local screenId = screen:id()

    local screenFrame = screen:frame()

    local rectW = screenFrame.w * screenProportion
    local rectH = screenFrame.h * screenProportion

    local singleSideUnusedProportion = (1 - screenProportion) / 2
    local rectX = screenFrame.w * singleSideUnusedProportion
    local rectY = screenFrame.h * singleSideUnusedProportion

    -- convert frame coordinates fromm primary's abs coordinates to current screen's local
    local updatedFrame = screen:localToAbsolute(hs.geometry.rect(rectX, rectY, rectW, rectH))
    window:setFrame(updatedFrame)
  end
end

local function switch_screen()
  local window = hs.window.focusedWindow()
  if not window then return end

  local screen = hs.fnutils.find(hs.screen.allScreens(), function(s) return s ~= window:screen() end)
  if not screen then return end

  -- Issue with Chromium and its derivatives https://github.com/Hammerspoon/hammerspoon/issues/3224#issuecomment-1294359070
  local axApp = hs.axuielement.applicationElement(window:application())
  local wasEnhanced = axApp.AXEnhancedUserInterface
  if wasEnhanced then
	  axApp.AXEnhancedUserInterface = false
  end

  window:moveToScreen(screen)

  if wasEnhanced then
    axApp.AXEnhancedUserInterface = true
  end

end

local navigationModifiers = {'alt', 'ctrl'}
hs.hotkey.bind(navigationModifiers, 'h', focus('west'))
hs.hotkey.bind(navigationModifiers, 'j', focus('south'))
hs.hotkey.bind(navigationModifiers, 'k', focus('north'))
hs.hotkey.bind(navigationModifiers, 'l', focus('east'))
hs.hotkey.bind(navigationModifiers, 'm', focus_window_under_mouse)
hs.hotkey.bind(navigationModifiers, '\\', switch_screen)
-- hs.hotkey.bind(navigationModifiers, '[', resize_focussed_window(.75))
