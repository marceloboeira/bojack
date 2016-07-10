require "./bojack/*"
require "socket"

module BoJack
  class Server
    def self.start
      server = TCPServer.new("localhost", 5000)
      server.recv_buffer_size = 4096
      data = Hash(String, String).new

      loop do
        socket = server.accept
        if socket
          spawn do
            loop do
              if request = socket.gets
                request = request.split(" ").map{|item| item.strip }
                command = request[0]

                if command == "ping"
                  socket.puts("pong")
                elsif command == "set"
                  key = request[1]
                  value = request[2]

                  data[key] = value

                  socket.puts(data[key])
                elsif command == "get"
                  key = request[1]

                  if data[key]?
                    value = data[key]
                    socket.puts(value)
                  else
                    socket.puts("error: '#{key}' is not a valid key")
                  end
                elsif command == "close"
                  socket.puts("closing...")

                  socket.close
                  break
                else
                  socket.puts("error: '#{command}' is not a valid command")
                end
              end
            end
          end
        end
      end
    end
  end
end
