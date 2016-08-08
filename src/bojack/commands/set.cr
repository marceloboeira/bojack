require "./command"

module BoJack
  module Commands
    class Set < BoJack::Commands::Command
      self.keyword = "set"

      def execute(memory, params)
        data = memory.write(params.key, params.value)

        if data.size == 1
          data.first
        else
          data
        end
      end
    end
  end
end
