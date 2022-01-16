-- disable animations
hs.window.animationDuration = 0

-- Navigation

-- focus windows by direction (like tmux)
-- yanked from https://gist.github.com/mtchllbrrn/efb5baabbafb8742fd52c826269dbdf0
local function focus(direction)
  local focusWindowFunction = "focusWindow" .. (direction:gsub("^%l", string.upper))

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

  local window = hs.fnutils.find(hs.window.orderedWindows(), function(w)
    return screen == w:screen() and position:inside(w:frame())
  end)

  if not window then return end
  window:focus()
end

local function resize_focussed_window(screenProportion)
  return function()
    local window = hs.window.focusedWindow()
    if not window then return end

    local windowFrame = window:frame()
    local screen = window:screen()
    local screenFrame = screen:frame()

    windowFrame.w = screenFrame.w * screenProportion
    windowFrame.h = screenFrame.h * screenProportion
    window:setFrame(windowFrame)

    -- this should be called after setFrame,
    -- if not frame's coordinates will override the position
    window:centerOnScreen(screen, true)
  end
end

local navigationModifiers = {"alt", "ctrl"}
hs.hotkey.bind(navigationModifiers, "h", focus("west"))
hs.hotkey.bind(navigationModifiers, "j", focus("south"))
hs.hotkey.bind(navigationModifiers, "k", focus("north"))
hs.hotkey.bind(navigationModifiers, "l", focus("east"))
hs.hotkey.bind(navigationModifiers, "m", focus_window_under_mouse)
hs.hotkey.bind(navigationModifiers, "]", resize_focussed_window(.75))
