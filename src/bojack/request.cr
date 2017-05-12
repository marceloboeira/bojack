require "socket"
require "./logger"
require "./command"

module BoJack
  abstract class Request
    abstract def perform
  end
end
