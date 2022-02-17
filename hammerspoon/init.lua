hs.spoons.use('SpoonInstall')

spoon.SpoonInstall:andUse('ReloadConfiguration')
spoon.ReloadConfiguration:start()

-- hs.logger.setGlobalLogLevel(5)

require 'utils'
require 'hotkey-extension'

require 'app-manager'
require 'media-manager'
require 'window-manager'
