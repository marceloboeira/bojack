module Bojack
  class Params
    @command : String
    @key : String
    @value : Array(String)

    def initialize(@command, @key, @value)
    end

    def command
      @command
    end

    def key
      @key
    end

    def value
      @value
    end

    def self.from(request : String)
      request = request.split(" ").map { |item| item.strip }

      command = ""
      key = ""
      value = ""

      begin
        command = request[0]
      rescue
      end

      begin
        key = request[1]
      rescue
      end

      begin
        value = request[2]
      rescue
      end

      Params.new(command, key, value.split(","))
    end
  end
end
