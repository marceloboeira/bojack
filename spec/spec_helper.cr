require "spec"

spawn do
  fake_logger = Logger.new(MemoryIO.new)
  BoJack::Server.new("127.0.0.1", 5000, fake_logger).start
end

# ensure the server has started before connection attempt
sleep 0.1
