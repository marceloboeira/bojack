module Bojack
  class Params
    @command : String
    @key : String
    @value : Array(String)
    getter :command, :key, :value

    def initialize(@command, @key, @value); end

    def self.from(request : String)
      request = request.split(" ").map { |item| item.strip }

      command = ""
      key = ""
      value = ""

      command = request[0] if request[0]?
      key = request[1] if request[1]?
      value = request[2] if request[2]?

      Params.new(command, key, value.split(","))
    end
  end
end
