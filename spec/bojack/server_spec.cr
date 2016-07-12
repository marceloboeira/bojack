require "../spec_helper"
require "../src/bojack/server"
require "socket"

describe BoJack::Server do
  Thread.new { BoJack::Server.start }

  TCPSocket.open("localhost", 5000) do |socket|
    describe "ping" do
      it "return pong" do
        socket.puts("ping")
        buffer = socket.gets

        buffer.should eq("pong\n")
      end
    end

    describe "set" do
      it "set key with value" do
        socket.puts("set bo jack")
        buffer = socket.gets

        buffer.should eq("jack\n")
      end
    end

    describe "get" do
      context "with a valid key" do
        it "return the key value" do
          socket.puts("get bo")
          buffer = socket.gets

          buffer.should eq("jack\n")
        end
      end

      context "with an invalid key" do
        it "return proper error message" do
          socket.puts("get bar")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key\n")
        end
      end
    end

    describe "delete" do
      context "with a valid key" do
        it "return the key value" do
          socket.puts("delete bo")
          buffer = socket.gets

          buffer.should eq("jack\n")
        end
      end

      context "with an invalid key" do
        it "return proper error message" do
          socket.puts("delete bar")
          buffer = socket.gets

          buffer.should eq("error: 'bar' is not a valid key\n")
        end
      end
    end

    describe "invalid command" do
      it "return proper error message" do
        socket.puts("jack")
        buffer = socket.gets

        buffer.should eq("error: 'jack' is not a valid command\n")
      end
    end
    socket.puts("close")
  end
end
