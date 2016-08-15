require "./command"

module BoJack
  module Commands
    class Set < BoJack::Commands::Command
      def execute(memory, params)
        key = params[:key].to_s
        value = params[:value]
        value = [value] if value.is_a?(String)

        data = memory.write(key, value)

        if data.size == 1
          data.first
        else
          data
        end
      end
    end
  end
end
