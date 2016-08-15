require "socket"
require "logger"
require "./memory"
require "./params"
require "./command"

module BoJack
  class Server
    @hostname : String
    @port : Int8 | Int16 | Int32 | Int64

    def initialize(@hostname = "127.0.0.1", @port = 5000)
      @logger = Logger.new(STDOUT)
    end

    def start
      server = TCPServer.new(@hostname, @port)
      server.recv_buffer_size = 4096
      memory = BoJack::Memory(String, Array(String)).new

      @logger.info("Server started on #{@hostname}:#{@port}")

      loop do
        if socket = server.accept
          @logger.info("#{socket.remote_address} connected")

          spawn do
            loop do
              request = socket.gets
              break unless request

              @logger.info("#{socket.remote_address} requested: #{request.dump}")

              params = BoJack::Params.from(request)
              command = BoJack::Command.from(params[:command])

              if command
                response = command.execute(memory, params[:params])
                socket.puts(response)
              elsif params[:command] == "close"
                socket.puts("closing...")
                @logger.info("#{socket.remote_address} closed the connection")

                socket.close
                break
              else
                socket.puts("error: '#{params[:command]}' is not a valid command")
              end
            end
          end
        end
      end
    end
  end
end
