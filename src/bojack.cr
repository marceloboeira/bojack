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
              if request = socket.gets
                command = request.strip

                if command == "ping"
                  socket.puts("pong")
                else
                  socket.puts("error: #{command} is not a valid command")
                end
              end
            end
          end
        end
      end
    end
  end
end
