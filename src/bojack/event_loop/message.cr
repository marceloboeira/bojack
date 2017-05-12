require "socket"
require "../request"

module BoJack
  module EventLoop
    class Message
      def initialize(@socket : TCPSocket, @channel : ::Channel::Unbuffered(BoJack::Request), @resp = false); end

      def start
        spawn do
          loop do
            if @resp
              @channel.send(BoJack::RESPRequest.new(@socket))
            else
              message = @socket.gets
              break unless message

              @channel.send(BoJack::PlainRequest.new(message, @socket))
            end
          end
        end
      end
    end
  end
end
