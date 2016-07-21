require "./command"

module Bojack
  module Commands
    class Pop < Command
      def execute(memory, key, value)
        memory.read(key).pop
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
