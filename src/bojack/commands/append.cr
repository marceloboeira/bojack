require "./command"

module BoJack
  module Commands
    class Append < BoJack::Commands::Command
      self.keyword = "append"

      def execute(memory, params)
        memory.append(params.key, params.value)
      rescue ex
        "error: '#{params.key}' is not a valid key"
      end
    end
  end
end
