require "../memory"

module Bojack
  module Commands
    # Represents a Bojack command
    #
    abstract class Command
      # Execute method
      #
      # Implements the process for command.
      #
      # @param memory [Bojack::Memory] to be managed.
      # @param key [String] for memory retrieve.
      # @param value [String] for memory changes.
      abstract def execute(memory, key : String?, value : String?) : String
    end
  end
end
