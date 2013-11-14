class Ci::WebSocket

  attr_reader :url, :client

  def initialize(url=nil)
    @url = url || 'http://localhost:9292/faye'
    @client = Faye::Client.new(@url)
  end

  def publish(args={})
    if args.keys.include?(:channel) and args.keys.include?(:data)
      @client.publish(args[:channel],args[:data])
    else
      raise ArgumentError, "Cannot publish a message without :channel nor :data"
    end
  end

end
