hs.spoons.use('SpoonInstall')

spoon.SpoonInstall:andUse('HoldToQuit', {start = true})
spoon.SpoonInstall:andUse('ReloadConfiguration', {start = true})

require 'utils'
require 'hotkey-extension'

require 'app-manager'
require 'media-manager'
require 'window-manager'
