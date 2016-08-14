require "./commands/*"

module BoJack
  module Command
    COMMANDS = {
      "append" => BoJack::Commands::Append,
      "delete" => BoJack::Commands::Delete,
      "get"    => BoJack::Commands::Get,
      "pop"    => BoJack::Commands::Pop,
      "set"    => BoJack::Commands::Set,
      "size"   => BoJack::Commands::Size,
    }

    # Factory method for BoJack Commands
    #
    # It holds the logic to create the command instances
    #
    # @param command [String]
    def self.from(keyword) : BoJack::Commands::Command?
      return COMMANDS[keyword].new if COMMANDS.has_key?(keyword)

      nil
    end
  end
end
