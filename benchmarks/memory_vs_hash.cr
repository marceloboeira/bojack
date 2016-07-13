require "../src/bojack/memory"
require "benchmark"

hash = {} of String => String
memory = BoJack::Memory(String, String).new

100_000.times do |i|
  hash["key#{i}"] = "value#{i}"
  memory.write("key#{i}", "value#{i}")
end

Benchmark.ips do |b|
  b.report("hash write") do
    hash["foo"] = "bar"
  end
  b.report("memory write") do
    memory.write("foo", "bar")
  end
end

Benchmark.ips do |b|
  b.report("hash read") do
    hash["foo"]? 
  end

  b.report("memory read") do
    memory.read("foo")
  end
end
