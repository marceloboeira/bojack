require "./command"

module BoJack
  module Commands
    class Set < BoJack::Commands::Command
      def execute(memory, params)
        key = params[0]
        value = params[1].split(",")

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
