module BoJack
  class Params
    def self.from(request : String) : NamedTuple(command: String, params: Array(String))
      request = request.split(" ").map { |item| item.strip }

      command = ""
      command = request[0] if request[0]?
      request.delete_at(0)

      { command: command, params: request }
    end
  end
end
