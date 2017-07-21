module KaribuCli
  class Configuration
    attr_accessor :workers,
                  :timeout,
                  :cache_ttl,
                  :cache_size,
                  :logger,
                  :log_enabled,
                  :env,
                  :symbolize_keys

    attr_reader   :services

    def initialize
      @services = []
    end

    def add_service(name, connection_string=:dynamic)
      @services << {name: name, address: connection_string}
    end

    def workers
      @workers || 10
    end

    def timeout
      @timeout || 30
    end

    def cache_ttl
      @cache_ttl
    end

    def cache_size
      @cache_size
    end

    def env
      @env || 'development'
    end

    def logger
      @logger || KaribuCli::Logger.new(KaribuCli.root.join("log/#{@env}.log"))
    end

    def log_enabled
      @log_enabled || true
    end

    def symbolize_keys
      @symbolize_keys || true
    end

    # @return [KaribuCli::Configuration] The server configuration
    def self.configuration
      @configuration ||= Configuration.new
    end

    # @return The configurator object
    def self.configure
      yield configuration
    end

    class << self
      attr_writer :configuration
    end
  end
end
