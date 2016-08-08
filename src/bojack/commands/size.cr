require "./command"

module BoJack
  module Commands
    class Size < BoJack::Commands::Command
      self.keyword = "size"

      def execute(memory, key, value)
        "#{memory.size}"
      end
    end
  end
end
