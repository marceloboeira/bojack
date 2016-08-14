require "./command"

module BoJack
  module Commands
    class Get < BoJack::Commands::Command
      def execute(memory, params)
        key = params[0]
        data = memory.read(key)

        if data.size == 1
          data.first
        else
          data
        end
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
