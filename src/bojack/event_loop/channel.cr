module BoJack
  module EventLoop
    class Channel(T)
      def initialize(@channel : ::Channel::Unbuffered(T)); end

      def start
        spawn do
          loop do
            if request = @channel.receive
              request.perform
            end
          end
        end
      end
    end
  end
end
