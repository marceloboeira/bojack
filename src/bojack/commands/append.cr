require "./command"

module BoJack
  module Commands
    class Append < BoJack::Commands::Command
      def execute(memory, params)
        key = params[0]
        value = params[1].split(",")

        memory.append(key, value)
      rescue ex
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
