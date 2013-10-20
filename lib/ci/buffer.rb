module Ci
  class Buffer
    attr_reader :stream

    def initialize(job)
      @job = job
    end

    def << (text)
      @job.update_attribute :log_output, text
      @stream = text
    end

  end
end
