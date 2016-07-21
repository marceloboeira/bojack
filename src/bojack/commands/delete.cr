require "./command"

module Bojack
  module Commands
    class Delete < Command
      def execute(memory, key : String?, value : Array(String))
        memory.delete(key).first
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
