require "logger"

# RedactingLogger is a custom logger that extends the standard Logger class.
# It redacts specified patterns in the log messages.
class RedactingLogger < Logger
  # Initializes a new instance of the RedactingLogger class.
  #
  # @param redact_patterns [Array<String>] The patterns to redact from the log messages.
  # @param log_device [Object] The log device (file, STDOUT, etc.) to write to.
  # @param kwargs [Hash] Additional options to pass to the Logger class.
  def initialize(redact_patterns, log_device, **kwargs)
    super(log_device, **kwargs)
    @redact_patterns = redact_patterns
  end

  # Adds a message to the log.
  #
  # @param severity [Integer] The severity level of the message.
  # @param message [String] The message to log.
  # @param progname [String] The name of the program.
  def add(severity, message = nil, progname = nil)
    if message
      @redact_patterns.each do |pattern|
        message = message.to_s.gsub(pattern, "[REDACTED]")
      end
    end

    if progname
      @redact_patterns.each do |pattern|
        progname = progname.to_s.gsub(pattern, "[REDACTED]")
      end
    end

    super(severity, message, progname)
  end
end
