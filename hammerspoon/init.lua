-- Navigation

-- focus windows by direction (like tmux)
-- yanked from https://gist.github.com/mtchllbrrn/efb5baabbafb8742fd52c826269dbdf0
local function focus(direction)
  local fn = "focusWindow" .. (direction:gsub("^%l", string.upper))

  return function()
    local win = hs.window.focusedWindow()
    if not win then return end

    win[fn]()
  end
end

function focus_window_under_mouse()
  -- yanked from https://gist.github.com/kizzx2/e542fa74b80b7563045a#gistcomment-3121012
  local pos = hs.geometry.new(hs.mouse.absolutePosition())
  local screen = hs.mouse.getCurrentScreen()

  local win = hs.fnutils.find(hs.window.orderedWindows(), function(w)
    return screen == w:screen() and pos:inside(w:frame())
  end)

  if not win then return end
  win:focus()
end

local navigationModifiers = {"alt", "ctrl"}
hs.hotkey.bind(navigationModifiers, "h", focus("west"))
hs.hotkey.bind(navigationModifiers, "j", focus("south"))
hs.hotkey.bind(navigationModifiers, "k", focus("north"))
hs.hotkey.bind(navigationModifiers, "l", focus("east"))
hs.hotkey.bind(navigationModifiers, "m", focus_window_under_mouse)