require "./spec_helper"
require "./../src/bojack"

describe BoJack::Server do
  Thread.new { BoJack::Server.start }

  TCPSocket.open("localhost", 5000) do |socket|
    it "pongs" do
      socket.puts("ping")

      buffer = socket.gets

      buffer.should eq("pong\n")
    end

    it "returns error" do
      socket.puts("jack")

      buffer = socket.gets

      buffer.should eq("error: jack is not a valid command\n")
    end
  end
end
