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
      # @param params [BoJack::Params] for params.
      abstract def execute(memory, params : BoJack::Params) : String | Array(String)

      private def self.keyword=(value : String)
        @@keyword = value
      end

      def self.keyword
        @@keyword
      end
    end
  end
end
