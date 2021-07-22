class Pac::FacturaElectronica::Receptor
    attr_accessor :tipo_receptor #iTipoRec
    attr_accessor :tipo_de_contribuyente #dTipoRuc
    attr_accessor :ruc #dRuc
    attr_accessor :dv_ruc #dDV
    attr_accessor :nombre #dNombRec
    attr_accessor :direccion #dDirecRec
    attr_accessor :codigo_ubicacion #dCodUbi
    attr_accessor :corregimiento #dCorreg
    attr_accessor :distrito #dDistr
    attr_accessor :provincia #dProv
    attr_accessor :identificacion_extranjero #dIdExt
    attr_accessor :pais_extranjero #dPaisExt
    attr_accessor :telefono     #dTfnRec
    attr_accessor :correo #dCorElectRec
    attr_accessor :pais #cPaisRec
    attr_accessor :pais_descripcion #dPaisRecDesc


    ##Recibe como parametro la seccion del hash que corresponde a gDatRec del xml
    ##
    #
    def initialize(xml_hash)
        @xml_hash = xml_hash
    end


    def cargar()
        
        @tipo_receptor = @xml_hash["iTipoRec"]
        @tipo_de_contribuyente = @xml_hash["gRucRec"]["dTipoRuc"]
        @ruc  =  @xml_hash["gRucRec"]["dRuc"]
        @dv_ruc  = @xml_hash["gRucRec"]["dDV"]
        @nombre  = @xml_hash["dNombRec"]
        @direccion  = @xml_hash["dDirecRec"]


        @codigo_ubicacion  = @xml_hash["gUbiRec"]["dCodUbi"]
        @corregimiento  = @xml_hash["gUbiRec"]["dCorreg"]
        @distrito  = @xml_hash["gUbiRec"]["dDistr"]
        @provincia  = @xml_hash["gUbiRec"]["dProv"]


        @identificacion_extranjero  = @xml_hash["gIdExt"]["dIdExt"]
        @pais_extranjero  = @xml_hash["gIdExt"]["dPaisExt"]


        @telefono  = @xml_hash["dTfnRec"] 
        @correo  = @xml_hash["dCorElectRec"]
        @pais  = @xml_hash["cPaisRec"]
        @pais_descripcion  = @xml_hash["dPaisRecDesc"]
    end 


end