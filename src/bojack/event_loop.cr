require "socket"
require "./logger"
require "./request"

module BoJack
  module EventLoop
    class Connection
      @logger : BoJack::Logger = BoJack::Logger.instance

      def initialize(@server : TCPServer, @channel : ::Channel::Unbuffered(BoJack::Request), @memory : BoJack::Memory(String, Array(String))); end

      def start
        loop do
          if socket = @server.accept
            @logger.info("#{socket.remote_address} connected")
            Message.new(socket, @channel, @memory).start
          end
        end
      end

    end

    class Message
      def initialize(@socket : TCPSocket, @channel : ::Channel::Unbuffered(BoJack::Request), @memory : BoJack::Memory(String, Array(String))); end

      def start
        spawn do
          loop do
            message = @socket.gets
            break unless message

            @channel.send(BoJack::Request.new(message, @socket, @memory))
          end
        end
      end
    end
  end
end
