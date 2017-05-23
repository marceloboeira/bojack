require "socket"
require "./logger"
require "./command"

module BoJack
  class Request
    @logger : BoJack::Logger = BoJack::Logger.instance

    def initialize(@connection : RESP::Connection, @params : Hash(Symbol, String | Array(String))); end

    def perform
      # @logger.info("#{@socket.remote_address} requested: #{@body.strip}")
      command = BoJack::Command.from(@params[:command].as(String).downcase)
      response = command.run(@connection, @params)

      @connection.send_string(response)
    rescue e : Errno
      # Broken pipe
      @connection.close
    rescue e
      message = "error: #{e.message}"
      @logger.error(message)
      @connection.send_string(message) unless @connection.closed?
    end
  end
end
