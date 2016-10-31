require "readline"
require "bojack-client"

module BoJack
  class Console
    def initialize(@hostname : String = "127.0.0.1", @port : Int8 | Int16 | Int32 | Int64 = 5000)
      begin
        @client = BoJack::Client.new(@hostname, @port)
      rescue exception
        puts exception.message
        exit -1
      end
    end

    def start
      loop do
        input = Readline.readline("> ", true)
        puts @client.send(input)
        break if input == "close"
      end
    end
  end
end
