module Ci
  class Environment

    attr_reader :session

    def initialize(buffer = nil)
      @session = Ci::SSH.new(
        user: 'simple-ci',
        host: 'simple-ci.tangosource.com',
        buffer: buffer
      )
    end

    def exec(command)
      @session.exec(command)
    end

    def upload_script(path_and_name, content)
      encoded = Base64.encode64(content).gsub("\n", "")
      command = "(echo #{encoded} | base64 --decode) >> #{path_and_name}"
      exec(command)
    end

  end
end
