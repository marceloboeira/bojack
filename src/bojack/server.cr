require "socket"
require "logger"
require "./memory"
require "./command"

module BoJack
  class Server
    @hostname : String
    @port : Int8 | Int16 | Int32 | Int64

    def initialize(@hostname = "127.0.0.1", @port = 5000, @logger = Logger.new(STDOUT)); end

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

              @logger.info("#{socket.remote_address} requested: #{request.strip}")

              params = parse_request(request)
              command = BoJack::Command.from(params[:command])

              if command
                response = command.execute(memory, params)
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

    private def parse_request(request) : Hash(Symbol, String | Array(String))
      request = request.split(" ").map { |item| item.strip }

      command = request[0]
      result = Hash(Symbol, String | Array(String)).new
      result[:command] = command

      result[:key] = request[1] if request[1]?
      result[:value] = request[2].split(",") if request[2]?

      result
    end
  end
end
