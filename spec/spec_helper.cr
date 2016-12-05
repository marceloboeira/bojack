require "spec"
require "./socket"

spawn do
  BoJack::Logger.build(MemoryIO.new)
  BoJack::Server.new(BoJack::SocketServer.create("127.0.0.1", 5000, "")).start
end

# ensure the server has started before connection attempt
sleep 0.1
