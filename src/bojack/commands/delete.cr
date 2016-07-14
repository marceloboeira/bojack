require "../commands/command"
require "../memory"

module Bojack
  module Commands
    class Delete < Command
      def execute(memory, key : String?, value : String?) : String
        memory.delete(key)
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
