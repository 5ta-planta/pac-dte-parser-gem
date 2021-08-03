class Pac::FacturaElectronica::Item
    attr_accessor :xml_hash
    attr_accessor :numero_item #dSecItem
    attr_accessor :descripcion_producto_servicio #dDescProd
    attr_accessor :codigo_interno #dCodProd
    attr_accessor :unidad_medida #cUnidad
    attr_accessor :cantidad_producto_servicio #dCantCodInt
    attr_accessor :fecha_fabricacion #dFechaFab
    attr_accessor :fecha_caducidad #dFechaCad
    attr_accessor :codigo_item_codificacion_panama_abbreviada #dCodCPBSabr
    attr_accessor :codigo_item_codificacion_panama #dCodCPBScmp
    attr_accessor :unidad_medida_codificacion_panama #cUnidadCPBS
    attr_accessor :informacion #dInfEmFE



    attr_accessor :precio_unitario #dPrUnit
    attr_accessor :descuento #dPrUnitDesc
    attr_accessor :precio #dPrItem
    attr_accessor :precio_acarreo #dPrAcarItem
    attr_accessor :precio_seguro #dPrSegItem
    attr_accessor :total #dValTotItem

    attr_accessor :codigo_gtin_unidad_comercializadora #dGTINCom
    attr_accessor :cantidad_gtin_unidad_comercializadora #dCantGTINCom
    attr_accessor :codigo_gtin_unidad_inventario #dGTINInv
    attr_accessor :cantidad_gtin_unidad_inventario #dCantComInvent


    attr_accessor :tasa_itbms #dTasaITBMS
    attr_accessor :monto_itbms #dValITBMS

    attr_accessor :tasa_isc #dTasaISC
    attr_accessor :monto_isc #dValISC

   # attr_accessor :tasa_otro_impuesto #dCodOTI
    #attr_accessor :monto_otro_impuesto #suma de dValOTI
    attr_accessor :lista_otros_impuestos

    attr_accessor :complemento_vehiculo_nuevo
    attr_accessor :complemento_medicina
    attr_accessor :complemento_pedido_comercial_relacionado

    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def monto_otros_impuestos
        if @lista_otros_impuestos.count == 0 
            return 0
        else
            retorno = 0
            @lista_otros_impuestos.each do |otro_impuesto|
                retorno = retorno + otro_impuesto.monto_otro_impuesto
            end

            return retorno
        end
    end


    def self.listar(hash)
        lista_items = []
        if (hash["rFE"]["gItem"].present?)
            if (hash["rFE"]["gItem"].class == Array)
                hash["rFE"]["gItem"].each_with_index do |item_hash, index|
                    item_factura =  Pac::FacturaElectronica::Item.new(item_hash)
                    item_factura.cargar()
                    lista_items << item_factura
                end
            else
                item_factura =  Pac::FacturaElectronica::Item.new(hash["rFE"]["gItem"])
                item_factura.cargar()
                lista_items << item_factura
            end
        end

        return lista_items
    end 


    def cargar()
    #     #6.5. Campos que Describen Cada Ítem de la Transacción Documentada
    #     @numero_item = @xml_hash["dSecItem"]
    #     @descripcion_producto_servicio  = @xml_hash["dDescProd"] 
    #     @codigo_interno  = @xml_hash["dCodProd"] 
    #     @unidad_medida  = @xml_hash["cUnidad"] 
    #     @cantidad_producto_servicio  = @xml_hash["dCantCodInt"].to_f if @xml_hash["dCantCodInt"].present?
    #     @fecha_fabricacion  = (@xml_hash["dFechaFab"]).to_time
    #     @fecha_caducidad  = (@xml_hash["dFechaCad"]).to_time
    #     @codigo_item_codificacion_panama_abbreviada  = @xml_hash["dCodCPBSabr"] 
    #     @codigo_item_codificacion_panama  = @xml_hash["dCodCPBScmp"] 
    #     @unidad_medida_codificacion_panama  = @xml_hash["cUnidadCPBS"] 
    #     @informacion  = @xml_hash["dInfEmFE"] 

    #     #6.5.1. Grupo de Precios del Ítem
    #     @precio_unitario  = @xml_hash["gPrecios"]["dPrUnit"].to_f if @xml_hash["gPrecios"]["dPrUnit"].present?
    #     @descuento  = @xml_hash["gPrecios"]["dPrUnitDesc"].to_f if @xml_hash["gPrecios"]["dPrUnitDesc"].present?
    #     @precio  = @xml_hash["gPrecios"]["dPrItem"].to_f if if @xml_hash["gPrecios"]["dPrItem"].present?
    #     @precio_acarreo  = @xml_hash["gPrecios"]["dPrAcarItem"].to_f if @xml_hash["gPrecios"]["dPrAcarItem"].present?
    #     @precio_seguro  = @xml_hash["gPrecios"]["dPrSegItem"].to_f if @xml_hash["gPrecios"]["dPrSegItem"].present?
    #     @total_item  = @xml_hash["gPrecios"]["dValTotItem"].to_f if @xml_hash["gPrecios"]["dValTotItem"].present?

    #     #6.5.2. Grupo de Otros Códigos del Ítem
    #     @codigo_gtin_unidad_comercializadora  = @xml_hash["gCodItem"]["dGTINCom"]
    #     @cantidad_gtin_unidad_comercializadora  = @xml_hash["gCodItem"]["dCantGTINCom"]


    #     @codigo_gtin_unidad_inventario  = @xml_hash["gCodItem"]["dGTINInv"]
    #     @cantidad_gtin_unidad_inventario  = @xml_hash["gCodItem"]["dCantComInvent"].to_f if @xml_hash["gCodItem"]["dCantComInvent"].present?

    #     #6.5.3. Grupo de ITBMS del Ítem
    #     @tasa_itbms  =  @xml_hash["gITBMSItem"]["dTasaITBMS"].to_f if  @xml_hash["gITBMSItem"]["dTasaITBMS"].present?
    #     @monto_itbms  = @xml_hash["gITBMSItem"]["dValITBMS"].to_f if @xml_hash["gITBMSItem"]["dValITBMS"].present?
        
    #     #6.5.4. Grupo de ISC del Ítem
    #     @tasa_isc  = @xml_hash["gISCItem"]["dTasaISC"].to_f if @xml_hash["gISCItem"]["dTasaISC"].present?
    #     @monto_isc  = @xml_hash["gISCItem"]["dValISC"].to_f if @xml_hash["gISCItem"]["dValISC"].present?

    #     #6.5.5. Grupo de Otras Tasas o Impuestos (OTI) del Ítem
    #    # @tasa_otro_impuesto  = @xml_hash["gOTIItem"]["dCodOTI"]
    #    # @monto_otro_impuesto  = @xml_hash["gOTIItem"]["dValOTI"]
    #    lista_otros_impuestos = Pac::FacturaElectronica::ItemOtroImpuesto.listar(@xml_hash)

    #     if (@xml_hash["gVehicNuevo"].present?)
    #         @complemento_vehiculo_nuevo = Pac::FacturaElectronica::CampoComplementario::VehiculoNuevo.new(@xml_hash["gVehicNuevo"])
    #         @complemento_vehiculo_nuevo.cargar()
    #     else
    #         @complemento@dte_parser_vehiculo_nuevo = nil
    #     end

    #     if (@xml_hash["gMedicina"].present?)
    #         @complemento_medicina = Pac::FacturaElectronica::CampoComplementario::Medicina.new(@xml_hash["gMedicina"])
    #         @complemento_medicina.cargar()
    #     else
    #         @complemento_medicina = nil
    #     end

    #     @complemento_pedido_comercial_relacionado_item= Pac::FacturaElectronica::CampoComplementario::InformacionPedidoComercialItem.new(@xml_hash["gPedComIr"])
    #     @complemento_pedido_comercial_relacionado_item.cargar()


    end 
end