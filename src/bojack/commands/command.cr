require "../memory"

module BoJack
  module Commands
    # Represents a BoJack command
    #
    abstract class Command
      @@keyword : String = "none"

      # Execute method
      #
      # Implements the process for command.
      #
      # @param memory [BoJack::Memory] to be managed.
      # @param key [String] for memory retrieve.
      # @param value [String] for memory changes.
      abstract def execute(memory, key : String?, value : Array(String)) : String | Array(String)

      private def self.keyword=(value : String)
        @@keyword = value
      end

      def self.keyword
        @@keyword
      end
    end
  end
end
