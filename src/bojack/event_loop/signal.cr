require "./socket"
require "../logger"

module BoJack
  module EventLoop
    class Signal
      @logger : BoJack::Logger = BoJack::Logger.instance

      def watch(server : BoJack::SocketServer)
        ::Signal::INT.trap do
          @logger.info("BoJack is going to take a rest")

          server.close

          exit
        end
      end
    end
  end
end
