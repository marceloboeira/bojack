module BoJack
  module EventLoop
    class Channel(T)
      def initialize(@channel : ::Channel::Unbuffered(T)); end

      def start
        spawn do
          loop do
            if action = @channel.receive
              action.perform 
            end
          end
        end
      end
    end
  end
end
