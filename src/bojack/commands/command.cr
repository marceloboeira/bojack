require "../memory"

module Bojack
  module Commands
    # Represents a Bojack command
    #
    # It is a interface that each command
    # must too implement.
    # 
    # @param memory [Bojack::Memory] to be managed.
    # @param key [String] for memory retrieve
    # @param value [String] for memory changes
    class Command
      def execute(memory, key : String?, value : String?)
        raise "Execution not implemented."
      end
    end
  end
end
