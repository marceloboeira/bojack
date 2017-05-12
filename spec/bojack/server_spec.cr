require "../spec_helper"
require "../../src/bojack/server"
require "socket"

describe BoJack::Server do
  hostname = "127.0.0.1"
  port = 5000
  c = Resp.new("redis://#{hostname}:#{port}")

  describe "ping" do
    it "returns pong" do
      c.call("ping").should eq("pong")
    end
  end

  describe "set" do
    it "sets key with value" do
      c.call("set bo jack".split(" ")).should eq("jack")
    end

    pending "sets key with a list" do
      c.call("set list boo,foo,bar".split(" ")).should eq("[\"boo\", \"foo\", \"bar\"]")
    end
  end

  describe "increment" do
    describe "with valid params" do
      it "increments the key value by 1" do
        c.call("set counter 10".split(" "))
        c.call("increment counter".split(" ")).should eq("11")
      end
    end

    describe "with an invalid key" do
      it "when the key does not exists" do
        result = c.call("increment invalid_counter".split(" "))
        result.should eq("error: 'invalid_counter' is not a valid key")
      end

      describe "when the key is an array" do
        it "raises proper error" do
          c.call("set counter a,b,c".split(" "))
          result = c.call("increment counter".split(" "))
          result.should eq("error: 'counter' cannot be incremented")
        end
      end

      describe "when the key is a string" do
        it "raises proper error" do
          c.call("set counter a".split(" "))

          result = c.call("increment counter".split(" "))
          result.should eq("error: 'counter' cannot be incremented")
        end
      end
    end
  end

  describe "get" do
    context "with a valid key" do
      it "returns the key value" do
        c.call("get bo".split(" ")).should eq("jack")
      end

      pending "returns a list" do
        c.call("get list".split(" ")).should eq("[\"boo\", \"foo\", \"bar\"]")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        c.call("get bar".split(" ")).should eq("error: 'bar' is not a valid key")
      end
    end
  end

  describe "append" do
    context "with a valid key" do
      pending "returns the key value" do
        c.call("set list boo,foo,bar".split(" "))
        result = c.call("append list lol".split(" "))
        result.should eq("[\"boo\", \"foo\", \"bar\", \"lol\"]")

        c.call("delete list".split(" "))
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        result = c.call("append bar lol".split(" "))
        result.should eq("error: 'bar' is not a valid key")
      end
    end
  end

  describe "pop" do
    context "with a valid key" do
      pending "returns the key value" do
        c.call("set list boo,foo,bar".split(" "))

        c.call("pop list".split(" ")).should eq("bar")

        c.call("delete list".split(" "))
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        result = c.call("append bar lol".split(" "))
        result.should eq("error: 'bar' is not a valid key")
      end
    end

    context "with no more items to pop" do
      pending "returns empty response" do
        c.call("set list foo,bar".split(" "))

        3.times { c.call("pop list".split(" ")) }

        c.call("delete list".split(" "))
      end
    end
  end

  describe "delete" do
    context "with a valid key" do
      it "returns the key value" do
        c.call("delete bo".split(" ")).should eq("jack")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        result = c.call("delete bar".split(" "))
        result.should eq("error: 'bar' is not a valid key")
      end
    end

    context "with a *" do
      it "returns {}" do
        c.call("delete *".split(" ")).should eq("{}")
      end
    end
  end

  describe "size" do
    it "reurns the size of the store" do
      c.call("set bo jack".split(" "))

      c.call("size").should eq("1")
    end
  end

  describe "invalid command" do
    it "returns proper error message" do
      c.call("jack").should eq("error: 'jack' is not a valid command")
    end
  end

  c.call("close")
end
