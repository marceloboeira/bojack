require "./command"

module Bojack
  module Commands
    class Set < Command
      def execute(memory, key, value)
        data = memory.write(key, value)

        if data.size == 1
          return data.first
        end

        data
      end
    end
  end
end
