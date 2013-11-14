require 'net/http'

class Ci::WebSocket

  attr_reader :uri

  def initialize(url=nil)
    @uri = URI.parse(url || 'http://localhost:9292/faye')
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
