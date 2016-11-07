require "socket"
require "../request"

module BoJack
  module EventLoop
    class Message
      def initialize(@socket : TCPSocket, @channel : ::Channel::Unbuffered(BoJack::Request)); end

      def start
        spawn do
          loop do
            message = @socket.gets
            break unless message

            @channel.send(BoJack::Request.new(message, @socket))
          end
        end
      end
    end
  end
end
