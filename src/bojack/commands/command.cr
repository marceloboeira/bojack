require "../memory"

module BoJack
  module Commands
    abstract class Command
      abstract def execute(memory, params : Array(String)) : String | Array(String)
    end
  end
end
