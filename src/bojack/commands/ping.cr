require "./command"

module BoJack
  module Commands
    class Ping < BoJack::Commands::Command
      def validate; end

      def perform(socket, memory, params)
        "pong"
      end
    end
  end
end
