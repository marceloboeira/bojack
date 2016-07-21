require "../spec_helper"
require "../../src/bojack/server"
require "socket"

describe BoJack::Server do
  hostname = "127.0.0.1"
  port = 5000

  spawn do
    BoJack::Server.new(hostname, port).start
  end

  # ensure the server has started before connection attempt
  sleep 0.1

  TCPSocket.open(hostname, port) do |socket|
    describe "ping" do
      it "returns pong" do
        socket.puts("ping")
        buffer = socket.gets

        buffer.should eq("pong\n")
      end
    end

    describe "set" do
      it "sets key with value" do
        socket.puts("set bo jack")
        buffer = socket.gets

        buffer.should eq("jack\n")
      end

      it "sets key with a list" do
        socket.puts("set list boo,foo,bar")
        buffer = socket.gets

        buffer.should eq("[\"boo\", \"foo\", \"bar\"]\n")
      end
    end

    describe "get" do
      context "with a valid key" do
        it "returns the key value" do
          socket.puts("get bo")
          buffer = socket.gets

          buffer.should eq("jack\n")
        end
      end

      context "with an invalid key" do
        it "returns proper error message" do
          socket.puts("get bar")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key\n")
        end
      end
    end

    describe "append" do
      context "with a valid key" do
        it "returns the key value" do
          socket.puts("set list boo,foo,bar")
          socket.gets

          socket.puts("append list lol")
          buffer = socket.gets

          buffer.should eq("[\"boo\", \"foo\", \"bar\", \"lol\"]\n")

          socket.puts("delete list")
          buffer = socket.gets
        end
      end

      context "with an invalid key" do
        it "returns proper error message" do
          socket.puts("append bar lol")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key\n")
        end
      end
    end

    describe "pop" do
      context "with a valid key" do
        it "returns the key value" do
          socket.puts("set list boo,foo,bar")
          socket.gets

          socket.puts("pop list")
          buffer = socket.gets

          buffer.should eq("bar\n")

          socket.puts("delete list")
          buffer = socket.gets
        end
      end

      context "with an invalid key" do
        it "returns proper error message" do
          socket.puts("append bar lol")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key\n")
        end
      end
    end

    describe "delete" do
      context "with a valid key" do
        it "returns the key value" do
          socket.puts("delete bo")
          buffer = socket.gets

          buffer.should eq("jack\n")
        end
      end

      context "with an invalid key" do
        it "returns proper error message" do
          socket.puts("delete bar")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key\n")
        end
      end
    end



    describe "size" do
      it "reurns the size of the store" do
        socket.puts("set bo jack")
        socket.gets

        socket.puts("size")
        buffer = socket.gets

        buffer.should eq("1\n")
      end
    end

    describe "invalid command" do
      it "returns proper error message" do
        socket.puts("jack")
        buffer = socket.gets

        buffer.should eq("error: 'jack' is not a valid command\n")
      end
    end
    socket.puts("close")
  end
end
