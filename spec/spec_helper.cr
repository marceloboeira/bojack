require "spec"
require "resp"

spawn do
  BoJack::Logger.build(IO::Memory.new)
  BoJack::Server.new("127.0.0.1", 5000).start
end

# ensure the server has started before connection attempt
sleep 0.0001
