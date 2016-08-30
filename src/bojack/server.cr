require "socket"
require "./memory"
require "./command"
require "./logger"
require "./version"

module BoJack
  class Server
    @hostname : String
    @port : Int8 | Int16 | Int32 | Int64

    def initialize(@hostname = "127.0.0.1", @port = 5000)
      @logger = BoJack::Log.instance(hostname: hostname, port: port)
    end

    def start
      server = TCPServer.new(@hostname, @port)
      server.tcp_nodelay = true
      server.recv_buffer_size = 4096
      memory = BoJack::Memory(String, Array(String)).new

      puts BoJack::Logo.build

      @logger.log.info("Server started at #{@hostname}:#{@port}")

      Signal::INT.trap do
        @logger.log.info("BoJack is going to take a rest")
        server.close
        exit
      end

      loop do
        if socket = server.accept
          @logger.log.info("#{socket.remote_address} connected")

          spawn do
            loop do
              request = socket.gets
              break unless request

              @logger.log.info("#{socket.remote_address} requested: #{request.strip}")

              begin
                params = parse_request(request)
                command = BoJack::Command.from(params[:command])

                response = command.run(socket, memory, params)

                if command.is_a?(BoJack::Commands::Close)
                  break
                end

                socket.puts(response)
              rescue e
                message = "error: #{e.message}"
                @logger.log.error(message)
                socket.puts(message)
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

  class Logo
    def self.build
      logo = String.build do |logo|
        logo << File.read(File.join(File.dirname(__FILE__), "logo"))
        logo << "BoJack #{BoJack::VERSION}"
      end
    end
  end
end
