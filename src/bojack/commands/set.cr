require "./command"

module Bojack
  module Commands
    class Set < Command
      self.keyword = "set"

      def execute(memory, key : String?, value : String?) : String
        memory.write(key, value)
      end
    end
  end
end
