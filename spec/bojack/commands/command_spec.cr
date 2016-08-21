require "../../spec_helper"
require "../../../src/bojack/commands/command"

class FakeCommand < BoJack::Commands::Command
  def validate
    required(:foo)
  end

  def perform(socket, memory, params)
    "return"
  end
end

describe BoJack::Commands::Command do
  socket = "  "
  memory = ["foo"]

  describe "with valid params" do
    params = Hash(Symbol, String | Array(String)).new

    params[:foo] = "bar"

    it "does not raise any error" do
      FakeCommand.new.run(socket, memory, params).should eq("return")
    end
  end

  describe "with invalid params" do
    params = Hash(Symbol, String | Array(String)).new

    describe "when the param is not present" do
      it "raises proper error" do
        expect_raises(BoJack::Commands::Command::MissingRequiredParam, "Param 'foo' is required but not present") do
          FakeCommand.new.run(socket, memory, params)
        end
      end
    end
  end
end
