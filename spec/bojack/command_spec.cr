require "../spec_helper"
require "../../src/bojack/command"
require "../../src/bojack/commands/*"


describe "BoJack::Command" do
  context "when receive set" do
    it "returns a Set command" do
      (Bojack::Command.from("set")).should be_a(Bojack::Commands::Set)
    end
  end

  context "when receive get" do
    it "returns a Get command" do
      (Bojack::Command.from("get")).should be_a(Bojack::Commands::Get)
    end
  end

  context "when receive delete" do
    it "returns a Delete command" do
      (Bojack::Command.from("delete")).should be_a(Bojack::Commands::Delete)
    end
  end

  context "when receive pop" do
    it "returns a Pop command" do
      (Bojack::Command.from("pop")).should be_a(Bojack::Commands::Pop)
    end
  end

  context "when receive append" do
    it "returns a Append command" do
      (Bojack::Command.from("append")).should be_a(Bojack::Commands::Append)
    end
  end

  context "when receive size" do
    it "returns a Size command" do
      (Bojack::Command.from("size")).should be_a(Bojack::Commands::Size)
    end
  end

  context "when receive unkowncommand" do
    it "returns a nil" do
      (Bojack::Command.from("unknowncommand")).should be_nil
    end
  end
end
