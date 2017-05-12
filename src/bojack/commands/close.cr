require "./command"

module BoJack
  module Commands
    class Close < BoJack::Commands::Command
      def validate; end

      def perform(socket, memory, params)
        socket.send_string("bye")
        socket.close

        "closing..."
      end
    end
  end
end
