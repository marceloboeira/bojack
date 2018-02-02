require "./command"

module BoJack
  module Commands
    class Invalid < BoJack::Commands::Command
      def validate; end

      def perform(socket, memory, params)
        "invalid command"
      end
    end
  end
end
