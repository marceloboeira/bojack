require "socket"
require "./logger"

module BoJack
  class SocketServer
    @@logger : ::Logger = BoJack::Logger.instance

    def self.create(hostname : String, port : Int8 | Int16 | Int32 | Int64, unix_socket_path : String) : TCPServer | UNIXServer
      if !unix_socket_path.empty?
        server = UNIXServer.new(unix_socket_path)
        @@logger.info("Server started at #{unix_socket_path}}")
      else
        server = TCPServer.new(hostname, port)
        server.tcp_nodelay = true
        @@logger.info("Server started at #{hostname}:#{port}")
      end
      server.recv_buffer_size = 4096
      server
    end
  end
end
