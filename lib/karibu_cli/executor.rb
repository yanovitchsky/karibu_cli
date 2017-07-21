module KaribuCli
  class Executor

    def initialize
      @config = KaribuCli::Configuration.configuration
      @worker_pool = Concurrent::ThreadPoolExecutor.new(
        min_threads: @config.workers,
        max_thread: @config.workers + (@config.workers / 2).round,
        max_queue: 100
      )
      @ctx = ::ZMQ::Context.new
    end

    def call(connection_string, payload)
      Concurrent::Future.execute(executor: @worker_pool) do
        request = KaribuCli::Request.new(payload[:resource], payload[:method], payload[:params]).encode
        socket = @ctx.socket(::ZMQ::REQ)
        socket.connect(connection_string)
        response = ""
        socket.send_string(request, 0)
        socket.recv_string response
        resp = KaribuCli::Response.new(response).decode
        socket.close
        resp
      end
    end
  end
end
