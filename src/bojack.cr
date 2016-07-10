require "./bojack/*"
require "socket"

module BoJack
  class Server
    def self.start
      server = TCPServer.new("localhost", 5000)
      server.recv_buffer_size = 4096

      loop do
        socket = server.accept
        if socket
          spawn do
            loop do
              request = socket.gets
              socket.puts("pong") if request
            end
          end
        end
      end
    end
  end
end
