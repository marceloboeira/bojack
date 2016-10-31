require "socket"
require "logger"
require "./logger"
require "./request"
require "./memory"
require "./logo"
require "./event_loop/channel"

module BoJack
  class Server
    @hostname : String
    @port : Int8 | Int16 | Int32 | Int64
    @logger : ::Logger = BoJack::Logger.instance
    @memory = BoJack::Memory(String, Array(String)).new

    def initialize(@hostname = "127.0.0.1", @port = 5000)
      @server = TCPServer.new(@hostname, @port)
      @server.tcp_nodelay = true
      @server.recv_buffer_size = 4096
    end

    def start
      print_logo
      log_started_at

      handle_signal_trap

      channel = Channel::Unbuffered(BoJack::Request).new
      BoJack::EventLoop::Channel(BoJack::Request).new(channel).start

      spawn_request_handler(channel)
    end

    private def print_logo
      BoJack::Logo.render
    end

    private def log_started_at
      @logger.info("Server started at #{@hostname}:#{@port}")
    end

    private def handle_signal_trap
      Signal::INT.trap do
        @logger.info("BoJack is going to take a rest")
        @server.close
        exit
      end
    end

    private def spawn_request_handler(channel)
      loop do
        if socket = @server.accept
          @logger.info("#{socket.remote_address} connected")

          spawn do
            loop do
              message = socket.gets
              break unless message
              channel.send(BoJack::Request.new(message, socket, @memory))
            end
          end
        end
      end
    end
  end
end
