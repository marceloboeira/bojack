require "./command"

module Bojack
  module Commands
    class Append < Command
      self.keyword = "append"

      def execute(memory, key, value)
        memory.append(key, value)
      rescue ex
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
