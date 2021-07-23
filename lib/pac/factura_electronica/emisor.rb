
##Representa un emisor de una factura electronica
##6.4.1. Grupo de Datos que Identifican al emisor
#
class Pac::FacturaElectronica::Emisor
    attr_accessor :xml_hash
    attr_accessor :tipo_de_contribuyente #dTipoRuc
    attr_accessor :ruc #dRuc
    attr_accessor :dv_ruc #dDV
    attr_accessor :nombre #dNombEm
    attr_accessor :sucursal #dSucEm
    attr_accessor :coordenadas #dCoordEm
    attr_accessor :direccion #dDirecEm
    attr_accessor :codigo_ubicacion #dCodUbi
    attr_accessor :corregimiento #dCorreg
    attr_accessor :distrito #dDistr
    attr_accessor :provincia #dProv
    attr_accessor :telefono_contacto #dTfnEm
    attr_accessor :correo #dCorElectEmi

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
        @codigo_ubicacion = @xml_hash["gUbiEm"]["dCodUbi"]
        @corregimiento = @xml_hash["gUbiEm"]["dCorreg"]
        @distrito = @xml_hash["gUbiEm"]["dDistr"]
        @provincia = @xml_hash["gUbiEm"]["dProv"]
        @telefono_contacto = @xml_hash["dTfnEm"]
        @correo = @xml_hash["dCorElectEmi"]
    end 

end