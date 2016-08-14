require "./command"

module BoJack
  module Commands
    class Ping < BoJack::Commands::Command
      def execute(memory, params)
        "pong"
      end
    end
  end
end
