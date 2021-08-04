class Pac::FacturaElectronica::CampoComplementario::Medicina
    attr_accessor :xml_hash
    attr_accessor :numero_lote #dNroLote
    attr_accessor :cantidad_productos #dCtLote

    def initialize(xml_hash)
        @xml_hash = xml_hash        
    end

    def cargar
        @numero_lote =@xml_hash["dNroLote"]
        @cantidad_productos = @xml_hash["dCtLote"]
    end

end