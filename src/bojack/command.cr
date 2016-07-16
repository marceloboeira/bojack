require "./commands/command"
require "./commands/set"
require "./commands/get"
require "./commands/delete"
require "./commands/size"

module Bojack
  module Command
    # Factory method for Bojack Commands
    #
    # It holds the logic to create the command instances
    #
    # @param param_command [String]
    def self.from(param_command) : Bojack::Commands::Command?
      case param_command
      when "set"
        Bojack::Commands::Set.new
      when "get"
        Bojack::Commands::Get.new
      when "delete"
        Bojack::Commands::Delete.new
      when "size"
        Bojack::Commands::Size.new
      else
        nil
      end
    end
  end
end
