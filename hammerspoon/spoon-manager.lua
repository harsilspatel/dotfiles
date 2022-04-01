hs.spoons.use('SpoonInstall')

spoon.SpoonInstall:andUse('ReloadConfiguration', {start = true})

hs.loadSpoon('SkyRocket'):new({
  opacity = 0.2, -- Opacity of resize canvas
  moveModifiers = {'ctrl', 'cmd'}, -- Which modifiers to hold to move a window?
  moveMouseButton = 'left', -- Which mouse button to hold to move a window?
  resizeModifiers = {'fn'}, -- Which modifiers to hold to resize a window?
  resizeMouseButton = 'left' -- Which mouse button to hold to resize a window?
})

local EVERY_SIX_HOURS = 60 * 60 * 6 -- seconds
hs.timer.doWhile(function() return true end, function()
  print('spoon-manager: updated all spoons! (ﾉ^_^)ﾉ')
  spoon.SpoonInstall:asyncUpdateAllRepos()
end, EVERY_SIX_HOURS)
