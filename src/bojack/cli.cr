require "commander"
require "logger"
require "./version"
require "./server"
require "./console"

cli = Commander::Command.new do |command|
  command.use = "BoJack"
  command.long = "A non-reliable in-memory key-value store."

  command.commands.add do |command|
    command.use = "version"
    command.short = "Shows the version."
    command.long = command.short

    command.run do
      puts "BoJack (#{BoJack::VERSION})"
    end
  end

  command.commands.add do |command|
    command.use = "server"
    command.short = "Starts a server."
    command.long = command.short

    command.flags.add do |flag|
      flag.name = "hostname"
      flag.long = "--hostname"
      flag.default = "127.0.0.1"
      flag.description = "Hostname."
    end

    command.flags.add do |flag|
      flag.name = "port"
      flag.long = "--port"
      flag.default = 5000
      flag.description = "Port."
    end

    command.flags.add do |flag|
      flag.name = "log"
      flag.long = "--log"
      flag.default = ""
      flag.description = "Log output file."
    end

    command.flags.add do |flag|
      flag.name = "log-level"
      flag.long = "--log-level"
      flag.default = 1
      flag.description = "Log severity."
    end

    command.run do |options, arguments|
      output =  if options.string["log"].empty?  STDOUT
               else
                 options.string["log"]
               end

      BoJack::Logger.build(output, options.int["log-level"].as(Int32), options.string["hostname"], options.int["port"].as(Int32))

      BoJack::Server.new(options.string["hostname"], options.int["port"]).start
    end
  end

  command.commands.add do |command|
    command.use = "client"
    command.short = "Starts a client."
    command.long = command.short

    command.flags.add do |flag|
      flag.name = "hostname"
      flag.long = "--hostname"
      flag.default = "127.0.0.1"
      flag.description = "Hostname."
    end

    command.flags.add do |flag|
      flag.name = "port"
      flag.long = "--port"
      flag.default = 5000
      flag.description = "Port."
    end

    command.run do |options, arguments|
      BoJack::Console.new(options.string["hostname"], options.int["port"]).start
    end
  end
end

Commander.run(cli, ARGV)
