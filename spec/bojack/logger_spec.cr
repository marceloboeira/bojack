require "logger"
require "../spec_helper"
require "../../src/bojack/logger"

describe "BoJack::Logger" do
  context "when it is accessed" do
    it "has always the same instance" do
      BoJack::Logger.instance.should eq(BoJack::Logger.instance)
    end

    it "is a logger instance" do
      BoJack::Logger.instance.log.should be_a(Logger)
    end
  end
end
