module KaribuCli
  class Client
    def initialize
      @executor = Executor.new
      @conf = Configuration.configuration
    end

    def call(service, payload)
      if is_defined?(service)
        begin
          cs = get_connection_string(service)
          query = {resource: payload[0], method: payload[1], params: payload[2]}
          @executor.call(cs, query)
        rescue ::StandardError => e
          Concurrent::Future.execute {raise e}
        end
      else
        Concurrent::Future.execute {raise "Service #{service} not declared"}
      end
    end

    private

    def is_defined?(service)
      services = @conf.services.map{|x| x[:name]}
      services.include?(service)
    end

    def get_connection_string(service)
      service_requested = @conf.services.select{|x| x[:name] == service}.first
      # raise service_requested.inspect
      if service_requested[:address] == :dynamic
        discover(service)
      else
        service_requested[:address]
      end
    end

    def discover(service)
      status, res = ::Convulse.discover(service)
      if status == :ok
        selected = res.sample
        "tcp://#{selected[:address]}:#{selected[:port]}"
      else
        raise res.to_s
      end
    end
  end
end
