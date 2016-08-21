require "./command"

module BoJack
  module Commands
    class Ping < BoJack::Commands::Command
      def validate; end

      def perform(memory, params)
        "pong"
      end
    end
  end
end
