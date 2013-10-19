class SidekiqStatus
  attr_reader :total, :busy, :available


  def initialize
    @busy = Sidekiq.redis { |c| c.scard 'workers' }
    @total = 25
    @available = 25 - @busy
  end
end
