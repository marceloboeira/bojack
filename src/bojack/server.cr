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

    def initialize(@hostname = "127.0.0.1", @port = 5000)
      @server = TCPServer.new(@hostname, @port)
      @server.tcp_nodelay = true
      @server.recv_buffer_size = 4096
    end

    def start
      print_logo
      @logger.info("Server started at #{@hostname}:#{@port}")
      handle_signal_trap

      spawn_channel

      loop do
        if socket = @server.accept
          @logger.info("#{socket.remote_address} connected")

          spawn do
            loop do
              message = socket.gets
              break unless message
              @channel.send(BoJack::Request.new(message, socket, @memory))
            end
          end
        end
      end
    end

    private def print_logo
      BoJack::Logo.render
    end

    private def handle_signal_trap
      Signal::INT.trap do
        @logger.info("BoJack is going to take a rest")
        @server.close
        exit
      end
    end

    private def spawn_channel
      spawn do
        loop do
          if request = @channel.receive
            request.perform
          end
        end
      end
    end
  end
end
