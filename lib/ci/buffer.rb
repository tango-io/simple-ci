require 'ansi_colors'

module Ci
  class Buffer

    attr_reader :stream

    def initialize(session_id)
      @session_id = session_id
      @stream = ""
      @ws = Ci::WebSocket.new
    end

    def << (text)
      @stream = AnsiColors.to_html(text)
      @ws.publish(
        channel: @session_id,
        data: {
          log: @stream
        }
      )
    end

  end
end
