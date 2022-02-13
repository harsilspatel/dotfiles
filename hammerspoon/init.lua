hs.spoons.use('SpoonInstall')

spoon.SpoonInstall:andUse('ReloadConfiguration')
spoon.ReloadConfiguration:start()

-- hs.logger.setGlobalLogLevel(5)

require 'debug-utils'
require 'hotkey-extension'
require 'app-manager'
require 'window-manager'
