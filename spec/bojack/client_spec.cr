require "../spec_helper"
require "../../src/bojack/client"

describe BoJack::Client do
  hostname = "127.0.0.1"
  port = 5000

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

  describe "increment" do
    describe "with valid params" do
      it "increments the key value by 1" do
        client.set("counter", "10")

        client.increment("counter").should eq("11\n")
      end
    end

    describe "with an invalid key" do
      describe "when the key does not exists" do
        it "raises proper error" do
          client.increment("invalid_counter").should eq("error: 'invalid_counter' is not a valid key\n")
        end
      end

      describe "when the key is an array" do
        it "raises proper error" do
          client.set("counter", "a,b,c")
          client.increment("counter").should eq("error: 'counter' cannot be incremented\n")
        end
      end

      describe "when the key is a string" do
        it "raises proper error" do
          client.set("counter", "a")
          client.increment("counter").should eq("error: 'counter' cannot be incremented\n")
        end
      end
    end

    client.delete("counter")
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
