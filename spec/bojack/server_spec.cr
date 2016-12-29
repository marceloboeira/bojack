require "../spec_helper"
require "../../src/bojack/server"
require "socket"

describe BoJack::Server do
  hostname = "127.0.0.1"
  port = 5000

  TCPSocket.open(hostname, port) do |socket|
    describe "ping" do
      it "returns pong" do
        socket.puts("ping")
        buffer = socket.gets

        buffer.should eq("pong")
      end
    end

    describe "set" do
      it "sets key with value" do
        socket.puts("set bo jack")
        buffer = socket.gets

        buffer.should eq("jack")
      end

      it "sets key with a list" do
        socket.puts("set list boo,foo,bar")
        buffer = socket.gets

        buffer.should eq("[\"boo\", \"foo\", \"bar\"]")
      end
    end

    describe "increment" do
      describe "with valid params" do
        it "increments the key value by 1" do
          socket.puts("set counter 10")
          buffer = socket.gets

          socket.puts("increment counter")
          buffer = socket.gets

          buffer.should eq("11")
        end
      end

      describe "with an invalid key" do
        describe "when the key does not exists" do
          socket.puts("increment invalid_counter")
          buffer = socket.gets

          buffer.should eq("error: 'invalid_counter' is not a valid key")
        end

        describe "when the key is an array" do
          it "raises proper error" do
            socket.puts("set counter a,b,c")
            buffer = socket.gets

            socket.puts("increment counter")
            buffer = socket.gets

            buffer.should eq("error: 'counter' cannot be incremented")
          end
        end

        describe "when the key is a string" do
          it "raises proper error" do
            socket.puts("set counter a")
            buffer = socket.gets

            socket.puts("increment counter")
            buffer = socket.gets

            buffer.should eq("error: 'counter' cannot be incremented")
          end
        end
      end
    end

    describe "get" do
      context "with a valid key" do
        it "returns the key value" do
          socket.puts("get bo")
          buffer = socket.gets

          buffer.should eq("jack")
        end

        it "returns a list" do
          socket.puts("get list")
          buffer = socket.gets

          buffer.should eq("[\"boo\", \"foo\", \"bar\"]")
        end
      end

      context "with an invalid key" do
        it "returns proper error message" do
          socket.puts("get bar")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key")
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

          buffer.should eq("[\"boo\", \"foo\", \"bar\", \"lol\"]")

          socket.puts("delete list")
          buffer = socket.gets
        end
      end

      context "with an invalid key" do
        it "returns proper error message" do
          socket.puts("append bar lol")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key")
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

          buffer.should eq("bar")

          socket.puts("delete list")
          buffer = socket.gets
        end
      end

      context "with an invalid key" do
        it "returns proper error message" do
          socket.puts("append bar lol")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key")
        end
      end

      context "with no more items to pop" do
        it "returns empty response" do
          socket.puts("set list foo,bar")
          socket.gets

          socket.puts("pop list")
          socket.gets
          socket.puts("pop list")
          socket.gets
          socket.puts("pop list")

          buffer = socket.gets

          buffer.should eq("")
          socket.puts("delete list")
          socket.gets
        end
      end
    end

    describe "delete" do
      context "with a valid key" do
        it "returns the key value" do
          socket.puts("delete bo")
          buffer = socket.gets

          buffer.should eq("jack")
        end
      end

      context "with an invalid key" do
        it "returns proper error message" do
          socket.puts("delete bar")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key")
        end
      end

      context "with a *" do
        it "returns {}" do
          socket.puts("delete *")
          buffer = socket.gets

          buffer.should eq("{}")
        end
      end
    end

    describe "size" do
      it "reurns the size of the store" do
        socket.puts("set bo jack")
        socket.gets

        socket.puts("size")
        buffer = socket.gets

        buffer.should eq("1")
      end
    end

    describe "invalid command" do
      it "returns proper error message" do
        socket.puts("jack")
        buffer = socket.gets

        buffer.should eq("error: 'jack' is not a valid command")
      end
    end
    socket.puts("close")
  end
end
