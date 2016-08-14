require "./command"

module BoJack
  module Commands
    class Delete < BoJack::Commands::Command
      def execute(memory, params)
        key = params[0]

        if key == "*"
          memory.reset
        else
          memory.delete(key).first
        end
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
