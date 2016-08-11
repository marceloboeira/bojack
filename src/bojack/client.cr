require "socket"

module BoJack
  class Client
    @hostname : String
    @port : Int8 | Int16 | Int32 | Int64

    def initialize(@hostname = "127.0.0.1", @port = 5000)
      @socket = TCPSocket.new(@hostname, @port)
    end

    def set(key, value)
      @socket.puts("set #{key} #{value}")
      @socket.gets
    end

    def get(key)
      @socket.puts("get #{key}")
      @socket.gets
    end

    def append(key, value)
      @socket.puts("append #{key} #{value}")
      @socket.gets
    end

    def pop(key)
      @socket.puts("pop #{key}")
      @socket.gets
    end

    def delete(key)
      @socket.puts("delete #{key}")
      @socket.gets
    end

    def ping
      @socket.puts("ping")
      @socket.gets
    end

    def size
      @socket.puts("size")
      @socket.gets
    end

    def close
      @socket.puts("close")
      @socket.gets
    end

    def execute(raw)
      @socket.puts(raw)
      @socket.gets
    end
  end
end
