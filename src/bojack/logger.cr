require "logger"

module BoJack
  class Logger
    @@logger : ::Logger = ::Logger.new(STDOUT)

    def self.build(io : (IO | String) = STDOUT, level : Int32 = 1, hostname : String = "127.0.0.1",  port : Int32 = 5000)
      if io.is_a?(String)
        basename = File.basename(io, ".log")
        path = File.dirname(io)
        timestamp = Time.now.to_s("%Y%m%d%H%M%S")

        io = File.new("#{path}/#{basename}_#{timestamp}.log", "w")
      end

      @@logger = ::Logger.new(io)
      @@logger.level = ::Logger::Severity.new(level)
      @@logger.formatter = ::Logger::Formatter.new do |severity, datetime, progname, message, io|
        io << "[bojack][#{hostname}:#{port}][#{datetime}][#{severity}] #{message}"
      end
    end

    def self.instance
      if @@logger.nil?
        self.build
      end

      @@logger
    end
  end
end
