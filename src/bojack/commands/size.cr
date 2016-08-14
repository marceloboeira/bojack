require "./command"

module BoJack
  module Commands
    class Size < BoJack::Commands::Command
      def execute(memory, params)
        "#{memory.size}"
      end
    end
  end
end
