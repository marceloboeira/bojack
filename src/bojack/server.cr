require "socket"
require "./memory"
require "./logger"
require "./request"
require "./logo"
require "./event_loop/*"

module BoJack
  class Server
    @logger : BoJack::Logger = BoJack::Logger.instance
    @@memory : BoJack::Memory(String, Array(String)) = BoJack::Memory(String, Array(String)).new

    def initialize(@hostname : String = "127.0.0.1", @port : Int8 | Int16 | Int32 | Int64 = 5000)
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

      BoJack::EventLoop::Connection.new(@server, channel).start
    end

    private def print_logo
      BoJack::Logo.render
    end

    private def log_started_at
      @logger.info("BoJack is running at #{@hostname}:#{@port}")
    end

    private def handle_signal_trap
      Signal::INT.trap do
        @logger.info("BoJack is going to take a rest")
        @server.close
        exit
      end
    end

    def self.memory
      @@memory
    end
  end
end
