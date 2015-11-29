require 'yubikey/neo'
require 'thor'

class Yubikey::Neo
  module CLI
    class YubiOATH < Thor
      class_option 'card-name',
                   desc: 'Name of the Yubikey device to use',
                   type: :string,
                   default: 'Yubikey'

      desc 'add NAME', 'Add a token'
      def add(name)
        neo.yubioath do |yubioath|
          yubioath.put(name: name, secret: ask('Secret:'))
          print "Token: "
          puts yubioath.calculate(name: name)
        end
      end

      desc 'delete NAME', 'Delete a token'
      def delete(name)
        neo.yubioath do |yubioath|
          yubioath.delete(name: name)
        end
      end

      desc 'list', 'List all tokens'
      def list
        neo.yubioath do |yubioath|
          yubioath.calculate_all(timestamp: Time.now).map do |name, token|
            puts "#{name}: #{token}"
          end
        end
      end

      desc 'token NAME', 'Retrieve a token'
      def token(name)
        neo.yubioath do |yubioath|
          puts yubioath.calculate(name: name, timestamp: Time.now)
        end
      end

      private

      def neo
        @neo ||= Yubikey::Neo.new(name: options['card-name'])
      end
    end
  end
end
