require "./command"

module BoJack
  module Commands
    class Pop < BoJack::Commands::Command
      def execute(memory, params)
        key = params[0]
        list = memory.read(key)

        return nil if list.empty?
        list.pop
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
