require "./commands/*"

module BoJack
  module Command
    COMMANDS = {
      "append" => BoJack::Commands::Append,
      "delete" => BoJack::Commands::Delete,
      "get" => BoJack::Commands::Get,
      "increment" => BoJack::Commands::Increment,
      "pop" => BoJack::Commands::Pop,
      "set" => BoJack::Commands::Set,
      "size" => BoJack::Commands::Size,
      "ping" => BoJack::Commands::Ping,
    }

    def self.from(keyword) : BoJack::Commands::Command?
      return COMMANDS[keyword].new if COMMANDS.has_key?(keyword)

      nil
    end
  end
end
