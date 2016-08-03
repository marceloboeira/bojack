require "../memory"

module Bojack
  module Commands
    # Represents a Bojack command
    #
    abstract class Command
      @@keyword : String = "none"

      # Execute method
      #
      # Implements the process for command.
      #
      # @param memory [Bojack::Memory] to be managed.
      # @param key [String] for memory retrieve.
      # @param value [String] for memory changes.
      abstract def execute(memory, key : String?, value : String?) : String

      private def self.keyword=(value : String)
        @@keyword = value
      end

      def self.keyword
        @@keyword
      end
    end
  end
end
