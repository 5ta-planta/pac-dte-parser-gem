class Pac::FacturaElectronica::Retencion
    attr_accessor :xml_hash
    attr_accessor :codigo_retencion    
    attr_accessor :monto_retencion

    def initialize(xml_hash)
          @xml_hash = xml_hash
    end

    def cargar
        @codigo_retencion = @xml_hash["cCodRetenc"]
        @monto_retencion = @xml_hash["cValRetenc"]
    end

end