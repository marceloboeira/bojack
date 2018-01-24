require "../spec_helper"
require "../../src/bojack/memory"

memory = BoJack::Memory(String, String).new

module Spec
  before_each do
    memory.write("diane", "nguyen")
    memory.write("todd", "chavez")
  end
end

describe BoJack::Memory do
  context "when reading" do
    context "a valid key" do
      it "reads the value" do
        memory.read("diane").should eq("nguyen")
      end
    end

    context "an invalid key" do
      it "raises invalid key error" do
        expect_raises(BoJack::Memory::InvalidKey) {
          memory.read("invalid")
        }
      end
    end
  end

  context "when writing" do
    it "writes the key, value" do
      value = memory.write("princess", "carolyn")

      value.should eq("carolyn")
      memory.read("princess").should eq("carolyn")
    end
  end

  context "when deleting" do
    context "a valid key" do
      it "deletes the key" do
        value = memory.delete("princess")

        value.should eq("carolyn")
        expect_raises(BoJack::Memory::InvalidKey) {
          memory.read("princess")
        }
      end
    end

    context "an invalid key" do
      it "raises an error" do
        expect_raises(BoJack::Memory::InvalidKey) {
          memory.read("princess")
        }
      end
    end

    context "an invalid key" do
      it "raises an error" do
        expect_raises(BoJack::Memory::InvalidKey) {
          memory.delete("princess")
        }
      end
    end
  end

  context "when reseting" do
    it "deletes every key" do
      memory.reset
      memory.size.should eq(0)
    end
  end

  context "when checking size" do
    it "returns the number of items" do
      memory.size.should eq(2)
    end
  end
end
