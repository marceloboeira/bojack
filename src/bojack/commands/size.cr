require "./command"

module Bojack
  module Commands
    class Size < Command
      self.keyword = "size"

      def execute(memory, key, value)
        "#{memory.size}"
      end
    end
  end
end
