module KaribuCli
  class Response
    attr_accessor :type, :id, :error, :result
    def initialize(packet)
      @packet = packet
      @symbolize_keys = KaribuCli::Configuration.configuration.symbolize_keys
    end

    def decode
      msg = MessagePack.unpack(@packet, :symbolize_keys => @symbolize_keys, :encoding => Encoding::UTF_8)
      [:type=, :id=, :error=, :result=].each_with_index do |meth, index|
        self.send(meth, msg[index])
      end
      self
    end
  end
end
