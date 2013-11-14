require 'net/http'

class Ci::WebSocket

  attr_reader :uri, :client

  def initialize(url=nil)
    @uri = URI.parse(url || 'http://localhost:9292/faye')
  end

  def publish(args={})
    if args.keys.include?(:channel) and args.keys.include?(:data)
      Net::HTTP.post_form(@uri, message: args)
    else
      raise ArgumentError, "Cannot publish a message without :channel nor :data"
    end
  end

end
