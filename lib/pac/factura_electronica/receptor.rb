class Pac::FacturaElectronica::Receptor
    attr_accessor :tipo #iTipoRec
    attr_accessor :tipo_de_contribuyente #dTipoRuc  1 natural, 2 jujridico
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
    attr_accessor :existe_gUbiRec 
    attr_accessor :existe_gIdExt
    attr_accessor :existe_gRucRec
    attr_accessor :xml_hash


    ##Recibe como parametro la seccion del hash que corresponde a gDatRec del xml
    ##
    #
    def initialize(xml_hash)
        @xml_hash = xml_hash
    end


    def cargar()
        
        @tipo = @xml_hash["iTipoRec"]
        @tipo_de_contribuyente = @xml_hash["gRucRec"]["dTipoRuc"].to_i if @xml_hash["gRucRec"]["dTipoRuc"].present?
        @ruc  =  @xml_hash["gRucRec"]["dRuc"]
        @dv_ruc  = @xml_hash["gRucRec"]["dDV"]
        @nombre  = @xml_hash["dNombRec"]
        @direccion  = @xml_hash["dDirecRec"]

        @existe_gUbiRec = @xml_hash["gUbiRec"].present?
        
        @existe_gRucRec = @xml_hash["gRucRec"].present?

        @codigo_ubicacion  = @xml_hash["gUbiRec"]["dCodUbi"]
        @corregimiento  = @xml_hash["gUbiRec"]["dCorreg"]
        @distrito  = @xml_hash["gUbiRec"]["dDistr"]
        @provincia  = @xml_hash["gUbiRec"]["dProv"].to_i if @xml_hash["gUbiRec"]["dProv"].present?


        if (@xml_hash["gIdExt"].present?)
            @identificacion_extranjero  = @xml_hash["gIdExt"]["dIdExt"] if @xml_hash["gIdExt"]["dIdExt"].present?
            @pais_extranjero  = @xml_hash["gIdExt"]["dPaisExt"] if @xml_hash["gIdExt"]["dPaisExt"].present?
        end
        
        @existe_gIdExt = validar_si_existe_grupoB406 # @xml_hash["gIdExt"].present?

        @telefono  = @xml_hash["dTfnRec"] 
        @correo  = @xml_hash["dCorElectRec"]
        @pais  = @xml_hash["cPaisRec"]
        @pais_descripcion  = @xml_hash["dPaisRecDesc"]
    end 

    def validar_si_existe_grupoB406
        if @xml_hash["gIdExt"].present?
            if @identificacion_extranjero.present?  and @pais_extranjero.present?
                return true
            else
                return false
            end
        else
            return false
        end
    end


end