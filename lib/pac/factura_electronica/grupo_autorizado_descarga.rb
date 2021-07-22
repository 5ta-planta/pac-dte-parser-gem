class Pac::FacturaElectronica::GrupoAutorizadoDescarga
    attr_accessor :tipo_de_contribuyente
    attr_accessor :ruc_autorizado
    attr_accessor :dv_ruc_autorizado
    attr_accessor :xml_hash

    def initialize(xml_hash)
        @xml_hash = xml_hash
    end



   


    def self.listar(hash)
         lista = []
        if (hash["rFE"]["gDGen"]["gAutXML"].present?)
            if (hash["rFE"]["gDGen"]["gAutXML"].class == Array)
                hash["rFE"]["gDGen"]["gAutXML"].each do |item_hash|
                    nuevo_item =  Pac::FacturaElectronica::GrupoAutorizadoDescarga.new(item_hash)
                    nuevo_item.cargar()
                    lista << nuevo_item
                end
            else
                nuevo_item =  Pac::FacturaElectronica::GrupoAutorizadoDescarga.new(hash["rFE"]["gDGen"]["gAutXML"])
                nuevo_item.cargar();
                lista << nuevo_item
            end
        end
        return lista
    end

    def cargar()
        @tipo_de_contribuyente = @xml_hash["gRucAutXML"]["dTipoRuc"]
        @ruc_autorizado = @xml_hash["gRucAutXML"]["dRuc"]
        @dv_ruc_autorizado = @xml_hash["gRucAutXML"]["dDV"]
    end 
end