module KaribuCli
  class Request
    attr_accessor :id, :resource, :method, :params

    def initialize(resource, method, params)
      @resource = resource
      @method = method
      @params = params
      @id = ::SecureRandom.hex(10)
    end

    def encode
      MessagePack.pack([0, @id, @resource, @method, @params])
    end
  end
end
