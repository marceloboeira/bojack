require "../../spec_helper"
require "../../../src/bojack/commands/increment"

describe BoJack::Commands::Increment do
  memory = BoJack::Memory(String, Array(String)).new

  describe "with valid params" do
    it "increments a given key" do
      memory.write("counter", ["10"])

      BoJack::Commands::Increment.new.perform([0], memory, { key: "counter" })

      memory.read("counter").first.should eq("11")
    end
  end
end
