require "../spec_helper"
require "../../src/bojack/server"
require "../../src/bojack/client"
require "socket"

describe BoJack::Client do
  # TODO: share the same server instance
  hostname = "127.0.0.1"
  port = 5001

  spawn do
    BoJack::Server.new(hostname, port).start
  end

  # ensure the server has started before connection attempt
  sleep 0.1
  client = BoJack::Client.new(hostname, port)

  describe "ping" do
    it "returns pong" do
      client.ping.should eq("pong\n")
    end
  end

  describe "set" do
    it "sets key with value" do
      client.set("bo", "jack").should eq("jack\n")
    end

    it "sets key with a list" do
      client.set("list", "boo,foo,bar").should eq("[\"boo\", \"foo\", \"bar\"]\n")
    end
  end

  describe "get" do
    context "with a valid key" do
      it "returns the key value" do
        client.get("bo").should eq("jack\n")
      end

      it "returns a list" do
        client.get("list").should eq("[\"boo\", \"foo\", \"bar\"]\n")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        client.get("love").should eq("error: 'love' is not a valid key\n")
      end
    end
  end

  describe "append" do
    context "with a valid key" do
      it "returns the key value" do
        client.set("list", "boo,foo,bar")
        client.append("list", "lol").should eq("[\"boo\", \"foo\", \"bar\", \"lol\"]\n")

        client.delete("list")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        client.append("bar", "lol").should eq("error: 'bar' is not a valid key\n")
      end
    end
  end

  describe "pop" do
    context "with a valid key" do
      it "returns the key value" do
        client.set("list", "boo,foo,bar")
        client.pop("list").should eq("bar\n")

        client.delete("list")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        client.append("bar", "lol").should eq("error: 'bar' is not a valid key\n")
      end
    end
  end

  describe "delete" do
    context "with a valid key" do
      it "returns the key value" do
        client.delete("bo").should eq("jack\n")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        client.delete("bar").should eq("error: 'bar' is not a valid key\n")
      end
    end
  end

  describe "size" do
    it "returns the size of the store" do
      client.set("bo", "jack")
      client.size.should eq("1\n")
    end
  end
end
