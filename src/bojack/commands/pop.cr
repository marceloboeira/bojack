require "./command"

module BoJack
  module Commands
    class Pop < BoJack::Commands::Command
      def validate
        required(:key)
      end

      def perform(socket, memory, params)
        key = params[:key].to_s
        list = memory.read(key)

        return nil if list.empty?
        list.pop
      end
    end
  end
end
