require "./commands/*"

module Bojack
  module Command
    REGISTRY = [
      Bojack::Commands::Get,
      Bojack::Commands::Set,
      Bojack::Commands::Delete,
      Bojack::Commands::Size,
      Bojack::Commands::Append,
      Bojack::Commands::Pop,
    ]

    # Factory method for Bojack Commands
    #
    # It holds the logic to create the command instances
    #
    # @param command [String]
    def self.from(keyword) : Bojack::Commands::Command?
      clazz = REGISTRY.find(nil) do |clazz|
        clazz.keyword == keyword
      end

      return clazz.new if clazz

      nil
    end
  end
end
