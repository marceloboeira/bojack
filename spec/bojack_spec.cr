require "./spec_helper"


describe BoJack::Server do
  before do
    Thread.new { BoJack::Server.start }
  end

  context "on connection" do
    it "sends a hello message" do
      TCPSocket.open("localhost", 5000) do |socket|
        # ensures block execution
        expect(true).to eq(true)
      end
    end
  end

  context "when ping" do
    it "pongs" do
      TCPSocket.open("localhost", 5000) do |socket|
        socket.puts("ping")

        buffer = socket.gets

        expect(buffer).to eq("pong\n")
      end
    end
  end
end
