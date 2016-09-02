require "socket"
require "logger"
require "./logger"
require "./request"
require "./memory"
require "./logo"

module BoJack
  class Server
    @hostname : String
    @port : Int8 | Int16 | Int32 | Int64
    @logger : ::Logger = BoJack::Logger.instance
    @channel : Channel::Unbuffered(BoJack::Request) = Channel(BoJack::Request).new
    @memory = BoJack::Memory(String, Array(String)).new

    def initialize(@hostname = "127.0.0.1", @port = 5000); end

    def start
      server = TCPServer.new(@hostname, @port)
      server.tcp_nodelay = true
      server.recv_buffer_size = 4096

      BoJack::Logo.render

      @logger.info("Server started at #{@hostname}:#{@port}")

      Signal::INT.trap do
        @logger.info("BoJack is going to take a rest")
        server.close
        exit
      end

      spawn do
        loop do
          if request = @channel.receive
            request.perform
          end
        end
      end

      loop do
        if socket = server.accept
          @logger.info("#{socket.remote_address} connected")

          spawn do
            loop do
              if message = socket.gets
                @channel.send(BoJack::Request.new(message, socket, @memory))
              end
            end
          end
        end
      end
    end
  end
end
