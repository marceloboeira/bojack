require "../memory"

module BoJack
  module Commands
    abstract class Command
      @@keyword : String = "none"

      abstract def execute(memory, params : Array(String)) : String | Array(String)

      private def self.keyword=(value : String)
        @@keyword = value
      end

      def self.keyword
        @@keyword
      end
    end
  end
end
