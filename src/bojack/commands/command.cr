require "../memory"

module BoJack
  module Commands
    abstract class Command
      abstract def execute(memory, params : Hash(Symbol, String | Array(String))) : String | Array(String)
    end
  end
end
