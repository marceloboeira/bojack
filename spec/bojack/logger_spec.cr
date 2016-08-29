require "logger"
require "../spec_helper"
require "../../src/bojack/logger"

describe "BoJack::Log" do
  context "when it is accessed" do
    it "has always the same instance" do
      BoJack::Log.instance.should eq(BoJack::Log.instance)
    end

    it "is a logger instance" do
      BoJack::Log.instance.log.should be_a(Logger)
    end
  end
end
