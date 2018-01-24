module BoJack
  module EventLoop
    class Channel(T)
      def initialize(@channel : ::Channel::Buffered(T)); end

      def start
        spawn do
          loop do
            begin
            if action = @channel.receive
              action.perform
            end
            rescue e
              message = "error-k: #{e.message}"
              puts(message)
            end
          end
        end
      end
    end
  end
end
