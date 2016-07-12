require "option_parser"
require "../version"
require "../server"

port = 5000

OptionParser.parse! do |parser|
  parser.banner = "Usage: bojack-server [options]"

  parser.on("-v", "--version", "Show version") do
    puts "BoJack version #{BoJack::VERSION}"
    exit 0
  end

  parser.on("-h", "--help", "Show this help") do
    puts parser
    puts
    exit 0
  end

  parser.on("-p PORT", "--port=PORT", "Specifies the port for the server (default=#{port})") do |p|
    port = p
  end
end

BoJack::Server.start(port)
