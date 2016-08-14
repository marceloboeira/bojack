require "../spec_helper"
require "../../src/bojack/command"
require "../../src/bojack/commands/*"


describe "BoJack::Command" do
  context "when receives 'set'" do
    it "returns a Set command" do
      (BoJack::Command.from("set")).should be_a(BoJack::Commands::Set)
    end
  end

  context "when receives 'get'" do
    it "returns a Get command" do
      (BoJack::Command.from("get")).should be_a(BoJack::Commands::Get)
    end
  end

  context "when receives 'delete'" do
    it "returns a Delete command" do
      (BoJack::Command.from("delete")).should be_a(BoJack::Commands::Delete)
    end
  end

  context "when receives 'pop'" do
    it "returns a Pop command" do
      (BoJack::Command.from("pop")).should be_a(BoJack::Commands::Pop)
    end
  end

  context "when receives 'append'" do
    it "returns a Append command" do
      (BoJack::Command.from("append")).should be_a(BoJack::Commands::Append)
    end
  end

  context "when receives 'size'" do
    it "returns a Size command" do
      (BoJack::Command.from("size")).should be_a(BoJack::Commands::Size)
    end
  end

  context "when receives 'ping'" do
    it "returns a Ping command" do
      (BoJack::Command.from("ping")).should be_a(BoJack::Commands::Ping)
    end
  end

  context "when receive unkowncommand" do
    it "returns a nil" do
      (BoJack::Command.from("unknowncommand")).should be_nil
    end
  end
end
