require "./command"

module BoJack
  module Commands
    class Get < BoJack::Commands::Command
      self.keyword = "get"

      def execute(memory, params)
        data = memory.read(params.key)

        if data.size == 1
          data.first
        else
          data
        end
      rescue
        "error: '#{params.key}' is not a valid key"
      end
    end
  end
end
