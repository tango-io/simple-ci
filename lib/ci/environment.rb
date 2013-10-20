module Ci
  class Environment

    attr_reader :session

    def initialize(buffer = nil)
      @session = Ci::SSH.new(
        user: 'simple-ci',
        host: '173.230.154.173',
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
