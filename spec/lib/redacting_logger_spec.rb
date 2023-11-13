require "logger"
require_relative "../spec_helper"
require_relative "../../lib/redacting_logger"

describe RedactingLogger do
  context "#initialize" do
    it "ensures the class is initialized properly" do
      redact_patterns = ["secret", "password"]
      level = Logger::INFO
      logger = RedactingLogger.new(
        redact_patterns: redact_patterns,
        log_device: STDOUT,
        level: level,
        redacted_msg: "!!!REDACTED!!!"
        )

      expect(logger.level).to eq(level)
      expect(logger.instance_variable_get(:@redact_patterns)).to eq(redact_patterns)
      expect(logger.instance_variable_get(:@logdev).dev).to eq(STDOUT)
      expect(logger.instance_variable_get(:@redacted_msg)).to eq("!!!REDACTED!!!")
    end

    it "ensures the class is initialized properly with default values" do
      logger = RedactingLogger.new
      expect(logger.level).to eq(Logger::DEBUG)
      expect(logger.instance_variable_get(:@redact_patterns)).to eq([])
      expect(logger.instance_variable_get(:@logdev).dev).to eq(STDOUT)
      expect(logger.instance_variable_get(:@redacted_msg)).to eq("[REDACTED]")
    end
  end
end
