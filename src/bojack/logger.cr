require "logger"

module BoJack
  class Log
    getter :log

    def initialize(io = STDOUT, severity = 1, hostname = "127.0.0.1", port = 5000)
      @log = Logger.new(io)
      @log.level = Logger::Severity.new(severity)
      @log.formatter = Logger::Formatter.new do |severity, datetime, progname, message, io|
        io << "[bojack][#{hostname}:#{port}][#{datetime}][#{severity}] #{message}"
      end
    end

    def self.instance(*args, **kwargs)
      @@instance ||= new(*args, **kwargs)
    end
  end
end
