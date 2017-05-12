require "socket"
require "resp"
require "../command"

module BoJack
  class RESPRequest < Request
    @logger : BoJack::Logger = BoJack::Logger.instance

    def initialize(@socket : TCPSocket); end

    def perform
      # @logger.info("#{@socket.remote_address} requested: #{@body.strip}")
      connection = RESP::Connection.new(@socket)
      params = parse(connection)
      command = BoJack::Command.from(params[:command])

      response = command.run(@socket, params)

      connection.send_string(response)
    rescue e
      message = "error: #{e.message}"
      @logger.error(message)
      connection.send_string(message) if connection
    end

    private def parse(connection) : Hash(Symbol, String | Array(String))
      command, args = connection.parse
      result = Hash(Symbol, String | Array(String)).new

      return result unless command

      result[:command] = command

      if args
        result[:key] = args[0].as(String) if args[0]?
        result[:value] = args[1].as(String) if args[1]?
      end

      result
    end
  end
end
