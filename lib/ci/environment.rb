module Ci
  class Environment

    attr_reader :session

    def initialize
      @session = Ci::SSH.new(user: 'simple-ci', host: '173.230.154.173')
    end

  end
end
