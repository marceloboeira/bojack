require "./commands/*"

module Bojack
  module Command
    # Factory method for Bojack Commands
    #
    # It holds the logic to create the command instances
    #
    # @param param_command [String]

    SET = "set"
    GET = "get"
    DELETE = "delete"
    POP = "pop"
    APPEND = "append"
    SIZE = "size"

    def self.from(param_command) : Bojack::Commands::Command?
      case param_command
      when Command::SET
        Bojack::Commands::Set.new
      when Command::GET
        Bojack::Commands::Get.new
      when Command::DELETE
        Bojack::Commands::Delete.new
      when Command::APPEND
        Bojack::Commands::Append.new
      when Command::POP
        Bojack::Commands::Pop.new
      when Command::SIZE
        Bojack::Commands::Size.new
      else
        nil
      end
    end

    def self.list_command?(command)
      ([ Command::LGET,
         Command::LSET,
         Command::LDELETE] of String).includes? command
    end

    def self.value_command?(command)
      ([ Command::GET,
         Command::SET,
         Command::DELETE ] of String).includes? command
    end
  end
end
