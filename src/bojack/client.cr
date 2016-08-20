require "socket"

module BoJack
  class Client
    @hostname : String
    @port : Int8 | Int16 | Int32 | Int64

    def initialize(@hostname = "127.0.0.1", @port = 5000)
      @socket = TCPSocket.new(@hostname, @port)
      @socket.tcp_nodelay = true
    end

    def set(key, value)
      execute("set #{key} #{value}")
    end

    def increment(key)
      execute("increment #{key}")
    end

    def get(key)
      execute("get #{key}")
    end

    def append(key, value)
      execute("append #{key} #{value}")
    end

    def pop(key)
      execute("pop #{key}")
    end

    def delete(key)
      execute("delete #{key}")
    end

    def ping
      execute("ping")
    end

    def size
      execute("size")
    end

    def close
      execute("close")
    end

    def execute(raw)
      @socket.puts(raw)
      @socket.gets
    end
  end
end
