require 'yubikey/neo'
require 'thor'

module Yubikey
  class Neo
    class CLI < Thor
      class YubiOATH < Thor
        namespace :otp
      end

      register(YubiOATH, 'otp', 'otp <command>', 'Manage OTPs via the YubiOATH applet')
    end
  end
end
