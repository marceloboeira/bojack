require "logger"

module BoJack
  class Logger < ::Logger
    @@instance : BoJack::Logger = BoJack::Logger.new(STDOUT)

    def self.build(io : (IO | String) = STDOUT, level : Int32 = 1, hostname : String = "127.0.0.1", port : Int32 = 5000)
      if io.is_a?(String)
        basename = File.basename(io, ".log")
        path = File.dirname(io)
        timestamp = Time.now.to_s("%Y%m%d%H%M%S")

        io = File.new("#{path}/#{basename}_#{timestamp}.log", "w")
      end

      @@instance = BoJack::Logger.new(io)
      @@instance.level = BoJack::Logger::Severity.new(level)
      @@instance.formatter = BoJack::Logger::Formatter.new do |severity, datetime, progname, message, io|
        datetime = datetime.to_utc.to_s("%Y-%m-%d %H:%M:%S.%L")
        io << "[bojack][#{hostname}:#{port}][#{datetime}][#{severity}] #{message}"
      end
    end

    def self.instance
      self.build if @@instance.nil?

      @@instance
    end
  end
end
