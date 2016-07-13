require "../spec_helper"
require "../src/bojack/memory"

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
      it "reads the value from memory" do
        memory.read("diane").should eq("nguyen")
      end
    end
    
    context "an invalid key" do
      it "raises invalid key error" do
        expect_raises {
          memory.read("invalid")
        }
      end
    end
  end
  
  context "when writing" do
    it "writes the key, value on the storage" do
      value = memory.write("princess", "carolyn")

      value.should eq("carolyn")
      memory.read("princess").should eq("carolyn")
    end
  end

  context "when deleting" do
    context "a valid key" do
      it "deletes the key from the memory" do
        value = memory.delete("princess")

        value.should eq("carolyn")
        expect_raises {
          memory.read("princess")
        }
      end
    end

    context "an invalid key" do
      it "raises an error" do
        expect_raises {
          memory.delete("princess")
        }
      end
    end 
  end
end
