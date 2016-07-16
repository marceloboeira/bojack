require "socket"
require "./memory"
require "./params"
require "./command"

module BoJack
  class Server
    @hostname : String
    @port : Int8 | Int16 | Int32 | Int64

    def initialize(@hostname = "127.0.0.1", @port = 5000); end

    def start
      server = TCPServer.new(@hostname, @port)
      server.recv_buffer_size = 4096
      memory = BoJack::Memory(String, String).new

      loop do
        if socket = server.accept
          spawn do
            loop do
              request = socket.gets
              break unless request

              params = Bojack::Params.from(request)
              bjcommand = Bojack::Command.from(params.command)

              if bjcommand
                response = bjcommand.execute(memory, params.key, params.value)
                socket.puts(response)
              elsif params.command == "ping"
                socket.puts("pong")
              elsif params.command == "close"
                socket.puts("closing...")
                socket.close
                break
              else
                socket.puts("error: '#{params.command}' is not a valid command")
              end
            end
          end
        end
      end
    end
  end
end
