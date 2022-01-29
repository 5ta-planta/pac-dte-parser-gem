class Pac::FacturaElectronica::DocumentoFiscalReferenciado
    attr_accessor :xml_hash
 
    attr_accessor :tipo_contribuyente   #dTipoRuc B6011
    attr_accessor :ruc_contribuyente    #dRuc B6012
    attr_accessor :dv_ruc_contribuyente #dDv B6013
    attr_accessor :nombre_emisor        #dNombEmRef  B602
    attr_accessor :fecha_emision        #dFechaDFRef B603 
    attr_accessor :cufe_fe_referenciada #dCUFERef B606 esto es un cufe valido
    attr_accessor :cufe 
    attr_accessor :numero_factura_papel #dNroFacPap B616 
    attr_accessor :numero_factura_impresora_fiscal #dNroFacIE B621

    attr_accessor :existe_gDFRef
    attr_accessor :existe_gDFRefFE
    attr_accessor :existe_gDFRefFacPap
    attr_accessor :existe_gDFRefFacIE        


    def initialize(xml_hash)
        @xml_hash            = xml_hash
        @existe_gDFRef       = false
        @existe_gDFRefFE     = false
        @existe_gDFRefFacPap = false
        @existe_gDFRefFacIE  = false
        @cufe_fe_referenciada= nil
        @cufe                = nil
        
        
    end

    def self.listar(hash)
        lista_doc_fiscal = []

        if (hash["rFE"]["gDGen"]["gDFRef"].present?)
            if (hash["rFE"]["gDGen"]["gDFRef"].class == Array)
                hash["rFE"]["gDGen"]["gDFRef"].each do |item_hash|
                    nuevo_item = Pac::FacturaElectronica::DocumentoFiscalReferenciado.new(item_hash)
                    nuevo_item.cargar()
                    lista_doc_fiscal << nuevo_item
                end
            else                
                nuevo_item = Pac::FacturaElectronica::DocumentoFiscalReferenciado.new(hash["rFE"]["gDGen"]["gDFRef"])
                nuevo_item.cargar()
                lista_doc_fiscal << nuevo_item
            end
        end
        return lista_doc_fiscal
    end

    def cargar()
        @existe_gDFRef = true
        @tipo_contribuyente = @xml_hash["gRucEmDFRef"]["dTipoRuc"].to_i
        @ruc_contribuyente = @xml_hash["gRucEmDFRef"]["dRuc"]
        @dv_ruc_contribuyente = @xml_hash["gRucEmDFRef"]["dDV"]
        @nombre_emisor = @xml_hash["dNombEmRef"]
        @fecha_emision = (@xml_hash["dFechaDFRef"]).to_time if @xml_hash["dFechaDFRef"].present?

        if @xml_hash["gDFRefNum"]["gDFRefFE"].present?
            @existe_gDFRefFE = true
            if @xml_hash["gDFRefNum"]["gDFRefFE"]["dCUFERef"].present?
                @cufe_fe_referenciada = @xml_hash["gDFRefNum"]["gDFRefFE"]["dCUFERef"]
                @cufe = Pac::FacturaElectronica::Cufe.new(@cufe_fe_referenciada)
                @cufe.cargar
            end 
        end

        if @xml_hash["gDFRefNum"]["gDFRefFacPap"].present?
            @existe_gDFRefFacPap  = true
            @numero_factura_papel =  @xml_hash["gDFRefNum"]["gDFRefFacPap"]["dNroFacPap"]
        end

        if @xml_hash["gDFRefNum"]["gDFRefFacIE"].present?
            @existe_gDFRefFacIE = true
            @numero_factura_impresora_fiscal = @xml_hash["gDFRefNum"]["gDFRefFacIE"]["dNroFacIE"]
        end

    end

end