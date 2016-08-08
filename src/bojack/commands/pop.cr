require "./command"

module BoJack
  module Commands
    class Pop < BoJack::Commands::Command
      self.keyword = "pop"

      def execute(memory, params)
        list = memory.read(params.key)
        
        return nil if list.empty?
        list.pop
      rescue
        "error: '#{params.key}' is not a valid key"
      end
    end
  end
end
