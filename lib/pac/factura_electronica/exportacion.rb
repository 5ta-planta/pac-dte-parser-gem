class Pac::FacturaElectronica::Exportacion
    attr_accessor :xml_hash
    attr_accessor :incoterm
    attr_accessor :moneda
    attr_accessor :moneda_descripcion
    attr_accessor :tipo_cambio
    attr_accessor :monto_moneda_extranjera
    attr_accessor :puerto_embarque
    attr_accessor :existe_gFExp


    def initialize(xml_hash)
        @xml_hash = xml_hash
        @existe_gFExp = false
    end


    def cargar
        @existe_gFExp = true
        @incoterm= @xml_hash["cCondEntr"]
        @moneda= @xml_hash["cMoneda"]
        @moneda_descripcion= @xml_hash["cMonedaDesc"]
        @tipo_cambio= @xml_hash["dCambio"]
        @monto_moneda_extranjera= @xml_hash["dVTotEst"]
        @puerto_embarque= @xml_hash["dPuertoEmbarq"]


    end


end