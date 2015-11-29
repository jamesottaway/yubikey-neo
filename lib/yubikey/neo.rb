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
      card_names(@name).each do |card_name|
        Context.tap do |context|
          begin
            card = context.card(card_name, :shared)
            yield card
          ensure
            card.disconnect unless card.nil?
          end
        end
      end
    end

    # Get the card names matching {name}
    def card_names(name)
      Context.tap do |cxt|
        cxt.readers.select { |name| name.include?(name) }
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
