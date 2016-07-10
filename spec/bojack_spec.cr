require "./spec_helper"
require "./../src/bojack"

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

    describe "invalid command" do
      it "return error" do
        socket.puts("jack")

        buffer = socket.gets

        buffer.should eq("error: jack is not a valid command\n")
      end
    end
  end
end
