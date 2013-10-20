module Ci
  class Buffer

    attr_reader :stream

    def initialize(session_id)
      @session_id = session_id
      @stream = ""
    end

    def << (text)
      @stream << text
      Pusher.trigger @session_id, 'log_update', log: @stream
    end

  end
end
