require "../commands/command"
require "../memory"

module Bojack
  module Commands
    class Size < Command
      def execute(memory, key : String?, value : String?) : String
        memory.size
      end
    end
  end
end
