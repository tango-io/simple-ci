module Ci

  class SSH

    attr_reader :user, :host, :password, :port, :buffer, :session

    def initialize(options={})
      #
      # Argument validations
      #
      raise_errors if options.empty?
      options.keys.each { |k| raise_errors unless argument_whitelist.include?(k) }

      @user     = options[:user]
      @host     = options[:host]
      @port     = options[:port]
      @password = options[:password]
      @buffer   = ""
    end

    def connect
      hash = {}
      hash.merge!(password: @password) if @password
      hash.merge!(port: @port)         if @port
      @session ||= Net::SSH.start(@host, @user, hash)
    end


    def exec(command)
      connect unless open?

      exit_code = nil

      @session.open_channel do |ch|
        ch.request_pty do |channel, success|
          raise StandardError, "could not obtain pty" unless success
          channel.exec("/bin/bash --login -c #{Shellwords.escape(command)}") do |ch, success|
            raise StandardError, "could not execute command" unless success
            ch.on_data do |ch, data|
              @buffer << data
            end

            ch.on_extended_data do |ch, data|
              @buffer << data
            end

            ch.on_request("exit-status") do |ch, data|
              exit_code = data.read_long
            end
          end
        end
      end

      @session.loop(1)
    end

    def close
      @session.close if open?
    end

    private

    def raise_errors
      raise ArgumentError, "Wrong arguments, you forgot to send host, and user?"
    end

    def argument_whitelist
      [:host, :user, :port, :password]
    end

    def open?
      @truesession && !@session.closed?
    end

  end

end
