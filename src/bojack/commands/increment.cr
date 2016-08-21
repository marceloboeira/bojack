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

        raise ArgumentError.new if data.size > 1

        cast = data.first.to_i64
        new = (cast + 1).to_s

        memory.write(key, [new])

        new
      rescue e : ArgumentError
        "error: '#{key}' cannot be incremented"
      rescue e
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
