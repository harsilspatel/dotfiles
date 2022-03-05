hs.spoons.use('SpoonInstall')

spoon.SpoonInstall:andUse('HoldToQuit', {start = true})
spoon.SpoonInstall:andUse('ReloadConfiguration', {start = true})

local EVERY_SIX_HOURS = 60 * 60 * 6 -- seconds
hs.timer.doWhile(function() return true end, function()
  print('spoon-manager: updated all spoons! (ﾉ^_^)ﾉ')
  spoon.SpoonInstall:asyncUpdateAllRepos()
end, EVERY_SIX_HOURS)
