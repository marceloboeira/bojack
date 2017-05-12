require "socket"
require "./memory"
require "./logger"
require "./request"
require "./request/*"
require "./logo"
require "./event_loop/*"

module BoJack
  class Server
    @logger : BoJack::Logger = BoJack::Logger.instance
    @@memory : BoJack::Memory(String, Array(String)) = BoJack::Memory(String, Array(String)).new

    def initialize(@hostname : String = "127.0.0.1", @port : Int8 | Int16 | Int32 | Int64 = 5000, @resp = false)
      @server = TCPServer.new(@hostname, @port)
      @server.tcp_nodelay = true
      @server.recv_buffer_size = 4096
    end

    def start
      print_logo
      handle_signal_trap
      start_connection_loop
    end

    private def print_logo
      BoJack::Logo.render(@logger)
    end

    private def handle_signal_trap
      BoJack::EventLoop::Signal.new.watch(@server)
    end

    private def start_connection_loop
      @logger.info("BoJack is running at #{@hostname}:#{@port}")

      channel = Channel::Unbuffered(BoJack::Request).new
      BoJack::EventLoop::Channel(BoJack::Request).new(channel).start

      BoJack::EventLoop::Connection.new(@server, channel, @resp).start
    end

    def self.memory
      @@memory
    end
  end
end
