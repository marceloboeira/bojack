require "./command"

module BoJack
  module Commands
    class Append < BoJack::Commands::Command
      self.keyword = "append"

      def execute(memory, key, value)
        memory.append(key, value)
      rescue ex
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
