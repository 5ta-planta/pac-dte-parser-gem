class Pac::FacturaElectronica::TotalOtraTasa
    attr_accessor :xml_hash
    attr_accessor :codigo_otras_tasas
    attr_accessor :total

    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def self.listar(hash)
        lista_total_otras_tasas = []
        if (hash["rFE"]["gTot"]["gOTITotal"].present?)
            if (hash["rFE"]["gTot"]["gOTITotal"].class == Array)
                hash["rFE"]["gTot"]["gOTITotal"].each do |otra_tasa|
                    nueva_informacion = Pac::FacturaElectronica::TotalOtraTasa.new(otra_tasa)
                    nueva_informacion.cargar();
                    lista_total_otras_tasas  << nueva_informacion
                end
            else
                nueva_informacion = Pac::FacturaElectronica::TotalOtraTasa.new(hash["rFE"]["gTot"]["gOTITotal"])
                nueva_informacion.cargar();
                lista_total_otras_tasas  << nueva_informacion
            end
        end
        return lista_total_otras_tasas
    end

    def cargar
        @codigo_otras_tasas = @xml_hash["dCodOTITotal"]
        @total = @xml_hash["dValOTITotal"]
    end
end