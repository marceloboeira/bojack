require "../../spec_helper"
require "../../../src/bojack/event_loop/channel"

class MyAction
  @@counter = 0

  def perform
    @@counter += 1
  end

  def self.counter
    @@counter
  end
end
describe BoJack::EventLoop::Channel do
  it "consumes the channel" do
    channel = Channel::Unbuffered(MyAction).new

    BoJack::EventLoop::Channel(MyAction).new(channel).start

    10.times do
      channel.send(MyAction.new)
    end

    MyAction.counter.should eq(10)
  end
end
