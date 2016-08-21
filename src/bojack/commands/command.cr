module BoJack
  module Commands
    abstract class Command
      class MissingRequiredParam < Exception; end
      def initialize
        @params = Hash(Symbol, String | Array(String)).new
      end

      def run(memory, params : Hash(Symbol, String | Array(String)))
        @params = params
        validate

        perform(memory, params)
      end

      private abstract def perform(memory, params : Hash(Symbol, String | Array(String))) : String | Array(String)

      private def validate; end

      private def required(name : Symbol)
        raise BoJack::Commands::Command::MissingRequiredParam.new("Param '#{name}' is required but not present") unless @params.has_key?(name)
      end
    end
  end
end
