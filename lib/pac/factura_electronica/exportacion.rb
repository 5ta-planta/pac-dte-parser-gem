class Pac::FacturaElectronica::Exportacion
    attr_accessor :xml_hash
    attr_accessor :incoterm
    attr_accessor :moneda_exportacion
    attr_accessor :modeda_exportacion_descripcion
    attr_accessor :tipo_de_cambio
    attr_accessor :monto_en_moneda_extranjera
    attr_accessor :puerto_embarque


    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def ping2 
        puts "Pong"
    end

    def cargar
        @incoterm= @xml_hash["cCondEntr"]
        @moneda_exportacion= @xml_hash["cMoneda"]
        @modeda_exportacion_descripcion= @xml_hash["cMonedaDesc"]
        @tipo_de_cambio= @xml_hash["dCambio"]
        @monto_en_moneda_extranjera= @xml_hash["dVTotEst"]
        @puerto_embarque= @xml_hash["dPuertoEmbarq"]
    end



end