module KaribuCli
  class Future
    extend Forwardable
    attr_accessor :blocking, :future
    def_delegators :future, :fulfilled, :state, :pending?, :rejected?

    def initialize(concurrent_future)
      @future = future
      @blocking = true
    end

    def value(wait=1)
      if wait == 0
        if future.value(0) == nil
          nil
        else
          handle_value
        end
      else

      end
    end

    def reason

    end

    # def self.get(concurrent_future, blocking=true)
    #   if blocking == true
    #     val = concurrent_future.value
    #     if val.nil?
    #       raise concurrent_future.reason
    #     else
    #       if val.result.nil?
    #         raise val.error
    #       else
    #         val.result
    #       end
    #     end
    #   else
    #
    #   end
    # end

    def self.get(concurrent_future)
      val = concurrent_future.value
      if val.nil?
        raise concurrent_future.reason.inspect
      else
        if val.result.nil?
          raise val.error
        else
          val.result
        end
      end
    end

    private
    def handle_value

    end
  end
end
