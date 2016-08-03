require "./command"

module Bojack
  module Commands
    class Get < Command
      self.keyword = "get"

      def execute(memory, key : String?, value : String?) : String
        memory.read(key)
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
