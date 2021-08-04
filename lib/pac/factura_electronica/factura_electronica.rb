##Clase para representar una Factura electronica de PAC
##
#
class Pac::FacturaElectronica::FacturaElectronica
    attr_accessor :xml_hash
    attr_accessor :version_del_formato # dVerForm
    attr_accessor :identificador_para_firma_electronica # dId
    attr_accessor :ambiente_destino # iAmb
    attr_accessor :tipo_de_emision # iTpEmis
    attr_accessor :fecha_hora_inicio_contingencia # dFechaCont
    attr_accessor :razon_operacion_contingencia # dMotCont
    attr_accessor :tipo_documento # iDoc
    attr_accessor :numero_documento_fiscal # dNroDF
    attr_accessor :punto_facturacion_documento_fiscal # dPtoFacDF
    attr_accessor :codigo_de_seguridad # dSeg
    attr_accessor :fecha_emision_documento # dFechaEm
    attr_accessor :fecha_salida_estimada_mercancias # dFechaSalida
    attr_accessor :naturaleza_operacion # iNatOp
    attr_accessor :tipo_operacion # iTipoOp
    attr_accessor :destino_operacion # iDest
    attr_accessor :formato_generacion_cafe # iFormCAFE
    attr_accessor :manera_entrega_cafe # iEntCAFE
    attr_accessor :envio_contenedor_cafe # dEnvFE
    attr_accessor :proceso_generacion_fe # iProGen
    attr_accessor :tipo_transaccion_venta # iTipoTranVenta
    attr_accessor :tipo_sucursal # iTipoSuc
    attr_accessor :informacion_interes_emisor_fe# dInfEmFE
    
    attr_accessor :emisor # Pac::FacturaElectronica::Emisor    
    attr_accessor :receptor # Pac::FacturaElectronica::Receptor    
    attr_accessor :exportacion # Pac::FacturaElectronica::Exportacion    
    #attr_accessor :doc_fiscal_referenciado # Pac::FacturaElectronica::DocumentoFiscalReferenciado
    
    attr_accessor :lista_doc_fiscal_referenciado

    attr_accessor :lista_grupo_autorizado_descarga # Pac::FacturaElectronica::GrupoAutorizadoDescarga

    attr_accessor :lista_items  # coleccion de items

    attr_accessor :sub_totales  # total y subtotales
    attr_accessor :lista_descuentos_bonificaciones_adicionales 
    attr_accessor :lista_formas_pago
    
    attr_accessor :retenciones # gRetenc

    attr_accessor :lista_informacion_pago_plazo
    attr_accessor :lista_total_otras_tasas

    attr_accessor :pedido_comercial
    attr_accessor :informacion_logistica
    attr_accessor :identificacion_local_de_entrega
    
    attr_accessor :firma_electronica #Signature
    attr_accessor :codigo_qr #dQRCode
  
    attr_accessor :resultado_validacion

    attr_accessor :cufe
    ##
    #
    def initialize(xml_fe_recep_fe)
        @xml_hash =  Hash.from_xml(xml_fe_recep_fe)
    end

    #Auxiliar para obtener los campos del DTE
     def campos
         json = JSON.parse self.to_json

         def agregar_llaves(keys, campo = 0)
          
            if keys.class.to_s == "String" or keys.class.to_s == "NilClass"
               puts "#{"-" * campo} #{keys.class}"
               return keys.class
            else
                 keys.keys.each do |key|
                    clase = keys[key].class.to_s               
                    if key != "xml_hash"
                         if clase == "Hash"   
                              puts "#{"-" * campo} #{key}"                              
                              agregar_llaves(keys[key], campo + 1)
                         else                
                              if clase == "Array"                                                                         
                                   puts "#{"-" * campo} #{key}"
                                   elemento = keys[key].first                                                                                                                                        
                                   agregar_llaves(elemento, campo + 1)
                              else                                                                      
                                   puts "#{"-" * campo} #{key}"
                              end
                         end
                    end
                 end

                return  true
               end
         end
         agregar_llaves(json)
     end



    def self.cargar_xml_prueba
        file = File.open(Rails.root+"xml_demo/fe-01.xml")
        xml = file.read
        #return Hash.from_xml(xml)
        xml
    end

    ##Metodo para cargar la FE a partir del XML 
    ##  
    #
    def cargar()
        cargar_datos_generales()
        cargar_datos_emisor()
        cargar_datos_receptor()
        cargar_exportacion()
        cargar_datos_doc_fiscal_referenciado()
        cargar_datos_grupo_autorizado_descarga()
        cargar_items()
        cargar_sub_totales()
        cargar_descuentos_bonificaciones_adicionales()
        cargar_forma_pago()
        cargar_retenciones()
        cargar_informacion_pago_plazo()
        cargar_complementos_uso_comercial_general()
        cargar_firma_electronica()
        cargar_datos_fuera_firma_electronica()
        @cufe = Pac::FacturaElectronica::Cufe.new(@identificador_para_firma_electronica)
        @cufe.cargar
        true
    rescue Exception => e
        p e.backtrace
        p e.message
         
    end

    ##Metodo que carga los datos del emisor
    ##6.4.1. Grupo de Datos que Identifican al emisor
    #
    def cargar_datos_emisor
        emisor_hash = @xml_hash["rFE"]["gDGen"]["gEmis"]
        @emisor = Pac::FacturaElectronica::Emisor.new(emisor_hash)
        @emisor.cargar();
    end


    ##Metodo que carga los datos del emisor
    ##6.4.2. Grupo de Datos que Identifican al Receptor
    #
    def cargar_datos_receptor
        receptor_hash = @xml_hash["rFE"]["gDGen"]["gDatRec"]
        @receptor = Pac::FacturaElectronica::Receptor.new(receptor_hash)
        @receptor.cargar();
    end
    

    ##Metodo que carga los datos de las exportaciones
    ##6.4.3. Grupo de Datos de Facturas en Caso de Exportación
    #
    def cargar_exportacion
        if (@xml_hash["rFE"]["gDGen"]["gFExp"].present?)
            exportacion_hash = @xml_hash["rFE"]["gDGen"]["gFExp"]
            @exportacion = Pac::FacturaElectronica::Exportacion.new(exportacion_hash)
            @exportacion.cargar()
        else
            @exportacion = Pac::FacturaElectronica::Exportacion.new("")
        end
    end
    

    ##Metodo que carga los datos del documento fiscal referenciado
    ##6.4.4. Grupo de Datos de Documento Fiscal Referenciado
    #
    def cargar_datos_doc_fiscal_referenciado
        @lista_doc_fiscal_referenciado = Pac::FacturaElectronica::DocumentoFiscalReferenciado.listar(@xml_hash)
        
    end
    
    ##Metodo que carga los datos del grupo autorizado para la descarga 
    ##6.4.5. Grupo de Autorizados a Descargar el Archivo de la FE y Sus Eventos
    #
    def cargar_datos_grupo_autorizado_descarga
        lista_grupo_autorizado_descarga = Pac::FacturaElectronica::GrupoAutorizadoDescarga.listar(@xml_hash)
    end
   

    ##Metodo que carga los datos de los items de las facturas
    ##6.5. Campos que Describen Cada Ítem de la Transacción Documentada
    #
    def cargar_items
        @lista_items = Pac::FacturaElectronica::Item.listar(@xml_hash)        
    end 

    ##Metodo que carga los datos del emisor
    ##6.6 Campos que Describen los Subtotales y Totales de la Transacción Documentada
    #
    def cargar_sub_totales
        sub_total_hash = @xml_hash["rFE"]["gTot"].present?        
        @sub_totales = Pac::FacturaElectronica::Subtotal.new(sub_total_hash)
        @sub_totales.cargar();
    end


    ##Metodo que carga los datos del emisor
    ##6.6 Campos que Describen los Subtotales y Totales de la Transacción Documentada
    #
    def cargar_sub_totales
        if (@xml_hash["rFE"]["gTot"].present?)
            sub_total_hash = @xml_hash["rFE"]["gTot"]    
            @sub_totales = Pac::FacturaElectronica::Subtotal.new(sub_total_hash)
            @sub_totales.cargar()
        end
    end

    ##Metodo que carga lista de los descuentos o bonificaciones adicionales
    ##6.6.1. Grupo de Datos que Describen Descuentos o Bonificaciones Adicionales Aplicados a la Factura
    #
    def cargar_descuentos_bonificaciones_adicionales
        @lista_descuentos_bonificaciones_adicionales = Pac::FacturaElectronica::DescuentoAdicional.listar(@xml_hash)
    end

    ##Metodo que carga lista de las formas de pago de la factura
    ##6.6.2. Grupo de Formas de Pago de la Factura
    #
    def cargar_forma_pago
        @lista_formas_pago = Pac::FacturaElectronica::FormaPago.listar(@xml_hash)
    end
    
    ##Metodo que carga retenciones de las facturas
    ##6.6.3. Grupo de Datos Cuando a la Factura le Aplican Retenciones
    #
    def cargar_retenciones
        if  @xml_hash["rFE"]["gTot"]["gRetenc"].present?        
            @retenciones = Pac::FacturaElectronica::Retencion.new(@xml_hash["rFE"]["gTot"]["gRetenc"])
            @retenciones.cargar()
        else
            @retenciones = nil
        end
    end
    
    ##Metodo que carga lista de las formas de pago de la factura
    ##6.6.4. Grupo de Información de Pago a Plazo
    #
    def cargar_informacion_pago_plazo
        @lista_informacion_pago_plazo = Pac::FacturaElectronica::PagoPlazo.listar(@xml_hash)
        @lista_total_otras_tasas = Pac::FacturaElectronica::TotalOtraTasa.listar(@xml_hash)
    end

    ##Metodo que carga lista de las formas de pago de la factura
    ##6.8. Campos Complementarios de Uso Comercial General
    #
    def cargar_complementos_uso_comercial_general
        cargar_pedido_comercial()
        cargar_informacion_logistica()
        cargar_identificacion_local_de_entrega()        
    end


    ##Metodo que carga datos de Pedido Comercial Relacionadas con la Factura
    ##6.8.1. Información del Pedido Comercial Relacionadas con la Factura
    #
    def cargar_pedido_comercial
        if  @xml_hash["rFE"]["gPedComGl"].present?        
            @pedido_comercial = Pac::FacturaElectronica::CampoComplementario::InformacionFactura.new(@xml_hash["rFE"]["gPedComGl"])
            @pedido_comercial.cargar()
        else-generada-rene-alejandro
            @pedido_comercial = nil
        end
    end

    ##Metodo que carga datos relacionados con la logistica
    ##6.8.2. Información de Logística
    #
    def cargar_informacion_logistica
        if  @xml_hash["rFE"]["gInfoLog"].present?        
            @informacion_logistica = Pac::FacturaElectronica::CampoComplementario::Logistica.new(@xml_hash["rFE"]["gInfoLog"])
            @informacion_logistica.cargar()
        else
            @informacion_logistica = nil
        end
    end

    ##Metodo que carga datos relacionados con local de entrega
    ##6.8.3. Información de local de entrega
    #
    def cargar_identificacion_local_de_entrega
        if  @xml_hash["rFE"]["gLcEntr"].present?        
            @identificacion_local_de_entrega = Pac::FacturaElectronica::CampoComplementario::LocalEntrega.new(@xml_hash["rFE"]["gLcEntr"])
            @identificacion_local_de_entrega.cargar()
        else
            @identificacion_local_de_entrega = nil
        end
    end    

    ##Metodo que carga datos relacionados con firma electronica
    ##6.9. Información de la Firma Electrónica de la FE
    #
    def cargar_firma_electronica
        @firma_electronica = @xml_hash["rFE"]["Signature"]
    end

    ##Metodo que carga campos fuera de firma electronica
    ##6.10. Campos Fuera de la Firma Electrónica de la FE
    #
    def cargar_datos_fuera_firma_electronica
        @codigo_qr = @xml_hash["rFE"]["gNoFirm"]["dQRCode"]
    end

    


    ##Metodo que carga los datos complementarios de la factura electronica de uso general
    ##6.8. Campos Complementarios de Uso Comercial General
    #
    def cargar_datos_generales
        @version_del_formato = @xml_hash["rFE"]["dVerForm"]
        @identificador_para_firma_electronica = @xml_hash["rFE"]["dId"]

        @ambiente_destino = @xml_hash["rFE"]["gDGen"]["iAmb"]
        @tipo_de_emision = @xml_hash["rFE"]["gDGen"]["iTpEmis"]
        
        @fecha_hora_inicio_contingencia = (@xml_hash["rFE"]["gDGen"]["dFechaCont"]).to_time if @xml_hash["rFE"]["gDGen"]["dFechaCont"].present?
        @razon_operacion_contingencia = @xml_hash["rFE"]["gDGen"]["dMotCont"]
        @tipo_documento = @xml_hash["rFE"]["gDGen"]["iDoc"]
        @numero_documento_fiscal = @xml_hash["rFE"]["gDGen"]["dNroDF"]
        @punto_facturacion_documento_fiscal = @xml_hash["rFE"]["gDGen"]["dPtoFacDF"]
        @codigo_de_seguridad = @xml_hash["rFE"]["gDGen"]["dSeg"]
        @fecha_emision_documento = (@xml_hash["rFE"]["gDGen"]["dFechaEm"]).to_time if @xml_hash["rFE"]["gDGen"]["dFechaEm"].present?
        @fecha_salida_estimada_mercancias = (@xml_hash["rFE"]["gDGen"]["dFechaSalida"]).to_time if @xml_hash["rFE"]["gDGen"]["dFechaSalida"].present?
        @naturaleza_operacion = @xml_hash["rFE"]["gDGen"]["iNatOp"]
        @tipo_operacion = @xml_hash["rFE"]["gDGen"]["iTipoOp"]
        @destino_operacion = @xml_hash["rFE"]["gDGen"]["iDest"]
        @formato_generacion_cafe = @xml_hash["rFE"]["gDGen"]["iFormCAFE"]
        @manera_entrega_cafe = @xml_hash["rFE"]["gDGen"]["iEntCAFE"]
        @envio_contenedor_cafe = @xml_hash["rFE"]["gDGen"]["dEnvFE"]
        @proceso_generacion_fe = @xml_hash["rFE"]["gDGen"]["iProGen"]
        @tipo_transaccion_venta = @xml_hash["rFE"]["gDGen"]["iTipoTranVenta"]
        @tipo_sucursal = @xml_hash["rFE"]["gDGen"]["iTipoSuc"]
        @informacion_interes_emisor_fe = @xml_hash["rFE"]["gDGen"]["dInfEmFE"]
    end

    def self.probar
#        xml_entrada_pp = File.open("public/fe-01-generada-rene-alejandro.xml").read
        xml_entrada_pp = File.open("   attr_accessor :cufepublic/fe-01.xml").read
        factura_electronica = Pac::FacturaElectronica::FacturaElectronica.new(xml_entrada_pp)        
        factura_electronica.cargar
        factura_electronica.validar
        
        return factura_electronica
    end

end

