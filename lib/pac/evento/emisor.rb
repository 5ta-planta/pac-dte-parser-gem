
##Representa un emisor de una factura electronica
##6.4.1. Grupo de Datos que Identifican al emisor
#
class Pac::Evento::Emisor
    attr_accessor :xml_hash
    attr_accessor :tipo_de_contribuyente #dTipoContEm
    attr_accessor :ruc #dRucEm 
    attr_accessor :dv_ruc #dDVEm 
    
    ##Recibe como parametro la seccion del hash que corresponde a gRucEm del xml
    ##
    #
    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def cargar()
        @tipo_de_contribuyente = @xml_hash["dTipoContEm"].to_i if @xml_hash["dTipoContEm"].present?
        @ruc  = @xml_hash["dRucEm"]
        @dv_ruc = @xml_hash["dDvEm"]
    end 

end