
##Representa un emisor de una factura electronica
##6.4.1. Grupo de Datos que Identifican al emisor
#
class Pac::FacturaElectronica::Emisor
    attr_accessor :xml_hash
    attr_accessor :tipo_de_contribuyente #dTipoRuc  B3011  1 natural, 2 jujridico 
    attr_accessor :ruc #dRuc B3012
    attr_accessor :dv_ruc #dDV B3013 
    attr_accessor :nombre #dNombEm B302
    attr_accessor :sucursal #dSucEm B303
    attr_accessor :coordenadas #dCoordEm B304
    attr_accessor :direccion #dDirecEm  B305 
    attr_accessor :codigo_ubicacion #dCodUbi B3061
    attr_accessor :corregimiento #dCorreg B3062
    attr_accessor :distrito #dDistr B3063
    attr_accessor :provincia #dProv B3064
    attr_accessor :telefono_contacto #dTfnEm B309
    attr_accessor :correo #dCorElectEmi  B310
    attr_accessor :existe_gUbiEm
    
    
    ##Recibe como parametro la seccion del hash que corresponde a gEmis del xml
    ##
    #
    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def cargar()
        
        @tipo_de_contribuyente = @xml_hash["gRucEmi"]["dTipoRuc"]
        @ruc  = @xml_hash["gRucEmi"]["dRuc"]
        @dv_ruc = @xml_hash["gRucEmi"]["dDV"]
        @nombre = @xml_hash["dNombEm"]
        @sucursal = @xml_hash["dSucEm"]
        @coordenadas = @xml_hash["dCoordEm"]
        @direccion = @xml_hash["dDirecEm"]
        @existe_gUbiEm = @xml_hash["gUbiEm"].present?
        @codigo_ubicacion = @xml_hash["gUbiEm"]["dCodUbi"]
        @corregimiento = @xml_hash["gUbiEm"]["dCorreg"]
        @distrito = @xml_hash["gUbiEm"]["dDistr"]
        @provincia = @xml_hash["gUbiEm"]["dProv"].to_i if @xml_hash["gUbiEm"]["dProv"].present?
        @telefono_contacto = @xml_hash["dTfnEm"]
        @correo = @xml_hash["dCorElectEmi"]
    end 

end