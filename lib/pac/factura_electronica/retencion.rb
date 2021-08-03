class Pac::FacturaElectronica::Retencion
    attr_accessor :xml_hash
    attr_accessor :codigo_retencion   #cCodRetenc d401  
    attr_accessor :monto_retencion    #cValRetenc d042

    def initialize(xml_hash)
          @xml_hash = xml_hash
    end

    def cargar
        @codigo_retencion = @xml_hash["cCodRetenc"]
        @monto_retencion = @xml_hash["cValRetenc"].to_f if @xml_hash["cValRetenc"].present?
    end

end