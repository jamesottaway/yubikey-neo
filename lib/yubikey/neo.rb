require 'smartcard'
require 'yubioath'

module Yubikey
  class Neo
    def initialize(name:)
      @name = name
    end

    def yubioath
      tap do |neo|
        yield YubiOATH.new(neo)
      end
    end

    def tap
      Context.tap do |context|
        begin
          card = context.card(@name, :shared)
          yield card
        ensure
          card.disconnect unless card.nil?
        end
      end
    end

    module Context
      extend self

      def tap
        context = Smartcard::PCSC::Context.new
        yield context
      ensure
        context.release
      end
    end
  end
end
