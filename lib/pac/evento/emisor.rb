
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
        puts "xml_hash #########"
        puts xml_hash
    end

    def cargar()
        @tipo_de_contribuyente = @xml_hash["gRucEmi"]["dTipoContEm"].to_i if @xml_hash["gRucEmi"]["dTipoContEm"].present?
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
        self.emisor_dynamo = Pac::Emisor::Emisor.where(ruc:self.ruc).first
    end 
    
    ###Valida que en dynamo exista la sucursal 
    ##
    #
    def sucursal_valida?
        self.emisor_dynamo.present? ? self.emisor_dynamo.sucursales.select {|suc| suc["codigo"] == self.sucursal }.present? 
                                    : false
    end

end