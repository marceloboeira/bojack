require "./command"

module BoJack
  module Commands
    class Delete < BoJack::Commands::Command
      def execute(memory, params)
        key = params[0]

        memory.delete(key).first
      rescue
        "error: '#{key}' is not a valid key"
      end
    end
  end
end
