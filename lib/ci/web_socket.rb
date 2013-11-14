require 'net/http'

module Ci
  class WebSocket

    attr_reader :uri

    def initialize(url=nil)
      @uri = URI.parse(url || 'http://simple-ci.r13.railsrumble.com/stream/faye')
    end

    def publish(args={})
      args = parse_info(args)
      Net::HTTP.post_form(@uri, message: args.to_json)
    end

    def parse_info(args)
      if args.keys.include?(:channel) and args.keys.include?(:data)
        { channel: "/#{args[:channel]}", data: args[:data] }
      else
        raise ArgumentError, "Cannot publish a message without :channel nor :data"
      end
    end

  end
end
