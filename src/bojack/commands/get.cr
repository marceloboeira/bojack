require "./command"

module BoJack
  module Commands
    class Get < BoJack::Commands::Command
      def validate
        required(:key)
      end

      def perform(socket, memory, params)
        key = params[:key].to_s
        data = memory.read(key)

        if data.size == 1
          data.first
        else
          data
        end
      end
    end
  end
end
