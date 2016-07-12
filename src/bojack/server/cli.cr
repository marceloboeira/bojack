require "option_parser"
require "../version"
require "../server"

port = 5000
hostname = "127.0.0.1"

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

  parser.on("-p PORT", "--port=PORT", "Server port (default=#{port})") do |p|
    port = p
  end

  parser.on("-h HOST", "--host=HOST", "Server hostname (default=#{hostname})") do |h|
    hostname = h
  end
end

BoJack::Server.start(hostname, port)
