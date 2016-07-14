require "../commands/command"
require "../memory"

module Bojack
  module Commands
    class Get < Command
      def execute(memory, key : String?, value : String?) : String
        memory.read(key)
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
