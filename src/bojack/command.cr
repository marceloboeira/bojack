require "./commands/*"

module BoJack
  module Command
    REGISTRY = [
      BoJack::Commands::Get,
      BoJack::Commands::Set,
      BoJack::Commands::Delete,
      BoJack::Commands::Size,
      BoJack::Commands::Append,
      BoJack::Commands::Pop,
    ]

    # Factory method for BoJack Commands
    #
    # It holds the logic to create the command instances
    #
    # @param command [String]
    def self.from(keyword) : BoJack::Commands::Command?
      clazz = REGISTRY.find(nil) do |clazz|
        clazz.keyword == keyword
      end

      return clazz.new if clazz

      nil
    end
  end
end
