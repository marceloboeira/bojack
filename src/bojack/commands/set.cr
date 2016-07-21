require "./command"

module Bojack
  module Commands
    class Set < Command
      def execute(memory, key, value)
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
