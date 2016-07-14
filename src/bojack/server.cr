require "socket"
require "./memory"
require "./commands/set"
require "./commands/get"
require "./commands/delete"

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

              request = request.split(" ").map { |item| item.strip }
              command = request[0]
              key = request[1]
              value = request[2] || ""

              if command == "ping"
                socket.puts("pong")
              elsif command == "set"

                cmd = Bojack::Commands::Set.new()
                response = cmd.execute(memory, key, value)

                socket.puts(response)
              elsif command == "get"
                key = request[1]
                cmd = Bojack::Commands::Get.new()
                response = cmd.execute(memory, key, value)

                socket.puts(response)
              elsif command == "delete"
                key = request[1]
                cmd = Bojack::Commands::Delete.new()
                response = cmd.execute(memory, key, value)

                socket.puts(response)
              elsif command == "size"
                socket.puts(memory.size)
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
