require "./command"

module BoJack
  module Commands
    class Pop < BoJack::Commands::Command
      self.keyword = "pop"

      def execute(memory, key, value)
        list = memory.read(key)
        
        return nil if list.empty?
        list.pop
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
