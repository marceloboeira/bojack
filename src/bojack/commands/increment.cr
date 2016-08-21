require "./command"

module BoJack
  module Commands
    class Increment < BoJack::Commands::Command
      def validate
        required(:key)
      end

      def perform(socket, memory, params)
        key = params[:key].to_s
        data = memory.read(key)

        raise ArgumentError.new("'#{key}' cannot be incremented") if data.size > 1

        cast = data.first.to_i64?

        raise ArgumentError.new("'#{key}' cannot be incremented") unless cast.is_a?(Int64)

        new = ((cast || 0) + 1).to_s

        memory.write(key, [new])

        new
      end
    end
  end
end
