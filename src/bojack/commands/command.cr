
module BoJack
  module Commands
    abstract class Command
      class MissingRequiredParam < Exception; end

      @memory : BoJack::Memory(String, Array(String)) = BoJack::Server.memory

      def initialize
        @params = Hash(Symbol, String | Array(String)).new
      end

      def run(socket, params : Hash(Symbol, String | Array(String)))
        @params = params
        validate

        perform(socket, @memory, params)
      end

      private abstract def perform(socket, memory, params : Hash(Symbol, String | Array(String))) : String | Array(String)

      private abstract def validate

      private def required(name : Symbol)
        raise BoJack::Commands::Command::MissingRequiredParam.new("Param '#{name}' is required but not present") unless @params.has_key?(name)
      end
    end
  end
end
