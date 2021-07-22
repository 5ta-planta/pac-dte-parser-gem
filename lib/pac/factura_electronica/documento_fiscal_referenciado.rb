class Pac::FacturaElectronica::DocumentoFiscalReferenciado
    attr_accessor :xml_hash
 
    attr_accessor :tipo_contribuyente
    attr_accessor :ruc_contribuyente
    attr_accessor :dv_ruc_contribuyente
    attr_accessor :nombre_emisor
    attr_accessor :fecha_emision
    attr_accessor :cufe_fe_referenciada
    attr_accessor :numero_factura_papel
    attr_accessor :numero_factura_impresora_fiscal



    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def self.listar(hash)
        lista_doc_fiscal = []

        if (hash["rFE"]["gDGen"]["gDFRef"].present?)
            if (hash["rFE"]["gDGen"]["gDFRef"].class == Array)
                hash["rFE"]["gDGen"]["gDFRef"].each do |item_hash|
                    nuevo_item = Pac::FacturaElectronica::DocumentoFiscalReferenciado.new(item_hash)
                    nuevo_item.cargar();
                    lista_doc_fiscal << nuevo_item
                end
            else                
                nuevo_item = Pac::FacturaElectronica::DocumentoFiscalReferenciado.new(hash["rFE"]["gDGen"]["gDFRef"])
                nuevo_item.cargar();
                lista_doc_fiscal << nuevo_item
            end
        end
        return lista_doc_fiscal

    end

    def cargar()
          
        @tipo_contribuyente = @xml_hash["gRucEmDFRef"]["dTipoRuc"]
        @ruc_contribuyente = @xml_hash["gRucEmDFRef"]["dRuc"]
        @dv_ruc_contribuyente = @xml_hash["gRucEmDFRef"]["dDv"]
        @nombre_emisor = @xml_hash["dNombEmRef"]
        @fecha_emision = @xml_hash["dFechaDFRef"]
        @cufe_fe_referenciada = @xml_hash["gDFRefNum"]["gDFRefFE"]["dCUFERef"]
        puts "Mensaje para el desarrollador: REVISAR ESTAS LINEAS DE CODIGO : #{Pac::FacturaElectronica::DocumentoFiscalReferenciado} LINEAS 42 Y 43"
       # @numero_factura_papel =  @xml_hash["gDFRefNum"]["gDFRefFacPap"]["dNroFacPap"]
       # @numero_factura_impresora_fiscal = @xml_hash["gDFRefNum"]["gDFRefFacIE"]["dNroFacIE"]
    end
    #113

end