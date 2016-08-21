require "./command"

module BoJack
  module Commands
    class Delete < BoJack::Commands::Command
      def validate
        required(:key)
      end

      def perform(socket, memory, params)
        key = params[:key].to_s

        if key == "*"
          memory.reset
        else
          memory.delete(key).first
        end
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
