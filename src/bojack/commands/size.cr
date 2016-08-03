require "./command"

module Bojack
  module Commands
    class Size < Command
      self.keyword = "size"

      def execute(memory, key : String?, value : String?) : String
        "#{memory.size}"
      end
    end
  end
end
