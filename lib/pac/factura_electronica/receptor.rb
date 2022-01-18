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
        self.tipo = nil
        self.tipo_de_contribuyente = nil
        self.ruc  = nil
        self.dv_ruc = nil
        self.nombre = nil
        self.direccion = nil
        self.codigo_ubicacion = nil
        self.corregimiento = nil
        self.distrito = nil
        self.provincia = nil
        self.identificacion_extranjero = nil
        self.pais_extranjero = nil
        self.telefono = nil
        self.correo = nil
        self.pais = nil
        self.pais_descripcion = nil
    end


    def cargar()
       
        @tipo = @xml_hash["iTipoRec"] if @xml_hash["iTipoRec"].present?

        ## Datos del ruc
        if @xml_hash["gRucRec"].present?
            @existe_gRucRec = true
            @tipo_de_contribuyente = @xml_hash["gRucRec"]["dTipoRuc"] if @xml_hash["gRucRec"]["dTipoRuc"].present?
            @ruc = @xml_hash["gRucRec"]["dRuc"] if @xml_hash["gRucRec"]["dRuc"].present?
            @dv_ruc  = @xml_hash["gRucRec"]["dDV"] if @xml_hash["gRucRec"]["dDV"].present?
        else
            @existe_gRucRec = false
        end

        ## Datos del la ubicacion
        if @xml_hash["gUbiRec"].present?
            @existe_gUbiRec = true
            @codigo_ubicacion  = @xml_hash["gUbiRec"]["dCodUbi"] if @xml_hash["gUbiRec"]["dDistr"].present?
            @corregimiento  = @xml_hash["gUbiRec"]["dCorreg"] if @xml_hash["gUbiRec"]["dDistr"].present?
            @distrito  = @xml_hash["gUbiRec"]["dDistr"] if @xml_hash["gUbiRec"]["dDistr"].present?
            @provincia  = @xml_hash["gUbiRec"]["dProv"] if @xml_hash["gUbiRec"]["dProv"].present?
        else
            @existe_gUbiRec = false
        end

        ## Datos del la extanjero
        if @xml_hash["gIdExt"].present?
            @existe_gUbiRec = true
            @identificacion_extranjero  = @xml_hash["gIdExt"]["dIdExt"] if @xml_hash["gIdExt"]["dIdExt"].present?
            @pais_extranjero  = @xml_hash["gIdExt"]["dPaisExt"] if @xml_hash["gIdExt"]["dPaisExt"].present?
        else
            @existe_gUbiRec = false
        end

        @nombre = @xml_hash["dNombRec"] if @xml_hash["dNombRec"].present?
        @direccion = @xml_hash["dDirecRec"] if @xml_hash["dDirecRec"].present?

        @telefono = @xml_hash["dTfnRec"] if @xml_hash["dTfnRec"].present?
        @correo = @xml_hash["dCorElectRec"] if @xml_hash["dCorElectRec"].present?
        @pais = @xml_hash["cPaisRec"] if @xml_hash["cPaisRec"].present?
        @pais_descripcion = @xml_hash["dPaisRecDesc"] if @xml_hash["dPaisRecDesc"].present?

      
    end 


end