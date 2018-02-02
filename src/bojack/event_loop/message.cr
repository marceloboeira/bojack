require "socket"
require "resp-server"
require "../request"

module BoJack
  module EventLoop
    class Message
      def initialize(@socket : TCPSocket, @channel : ::Channel::Unbuffered(BoJack::Request)); end

      def start
        spawn do
          begin
            loop do
              connection = RESP::Connection.new(@socket)
              params = parse(connection)

              @channel.send(BoJack::Request.new(connection, params))
            end
          rescue e
            # Client closed connection
            # Silently ignore?
          end
        end
      end

      private def parse(connection) : Hash(Symbol, String | Array(String))
        command, args = connection.parse
        result = Hash(Symbol, String | Array(String)).new

        unless command
          result[:command] = "invalid"
          return result
        end

        result[:command] = command

        if args
          result[:key] = args[0].as(String) if args[0]?
          result[:value] = args[1].as(String) if args[1]?
        end

        result
      end
    end
  end
end
