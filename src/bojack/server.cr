require "./socket"
require "./memory"
require "./logger"
require "./request"
require "./logo"
require "./event_loop/*"

module BoJack
  class Server
    @logger : BoJack::Logger = BoJack::Logger.instance
    @@memory : BoJack::Memory(String, Array(String)) = BoJack::Memory(String, Array(String)).new

    def initialize(@socket_server = BoJack::SocketServer.create("127.0.0.1", 5000, "")); end

    def start
      print_logo
      handle_signal_trap
      start_connection_loop
    end

    private def print_logo
      BoJack::Logo.render
    end

    private def handle_signal_trap
      BoJack::EventLoop::Signal.new.watch(@socket_server)
    end

    private def start_connection_loop
      @logger.info("BoJack is running at #{@hostname}:#{@port}")

      channel = Channel::Unbuffered(BoJack::Request).new
      BoJack::EventLoop::Channel(BoJack::Request).new(channel).start

      BoJack::EventLoop::Connection.new(@socket_server, channel).start
    end

    def self.memory
      @@memory
    end
  end
end
