require "./command"

module BoJack
  module Commands
    class Size < BoJack::Commands::Command
      def validate; end

      def perform(memory, params)
        "#{memory.size}"
      end
    end
  end
end
