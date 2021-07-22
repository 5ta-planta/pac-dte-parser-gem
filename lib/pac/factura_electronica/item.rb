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
   # attr_accessor :monto_otro_impuesto #dValOTI
    attr_accessor :lista_otros_impuestos

    attr_accessor :complemento_vehiculo_nuevo
    attr_accessor :complemento_medicina
    attr_accessor :complemento_pedido_comercial_relacionado

    def initialize(xml_hash)
        @xml_hash = xml_hash
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
        #6.5. Campos que Describen Cada Ítem de la Transacción Documentada
        @numero_item = @xml_hash["dSecItem"]
        @descripcion_producto_servicio  = @xml_hash["dDescProd"] 
        @codigo_interno  = @xml_hash["dCodProd"] 
        @unidad_medida  = @xml_hash["cUnidad"] 
        @cantidad_producto_servicio  = @xml_hash["dCantCodInt"] 
        @fecha_fabricacion  = @xml_hash["dFechaFab"] 
        @fecha_caducidad  = @xml_hash["dFechaCad"] 
        @codigo_item_codificacion_panama_abbreviada  = @xml_hash["dCodCPBSabr"] 
        @codigo_item_codificacion_panama  = @xml_hash["dCodCPBScmp"] 
        @unidad_medida_codificacion_panama  = @xml_hash["cUnidadCPBS"] 
        @informacion  = @xml_hash["dInfEmFE"] 

        #6.5.1. Grupo de Precios del Ítem
        @precio_unitario  = @xml_hash["gPrecios"]["dPrUnit"]
        @descuento  = @xml_hash["gPrecios"]["dPrUnitDesc"]
        @precio  = @xml_hash["gPrecios"]["dPrItem"]
        @precio_acarreo  = @xml_hash["gPrecios"]["dPrAcarItem"]
        @precio_seguro  = @xml_hash["gPrecios"]["dPrSegItem"] 
        @total_item  = @xml_hash["gPrecios"]["dValTotItem"] 

        #6.5.2. Grupo de Otros Códigos del Ítem
        @codigo_gtin_unidad_comercializadora  = @xml_hash["gCodItem"]["dGTINCom"]
        @cantidad_gtin_unidad_comercializadora  = @xml_hash["gCodItem"]["dCantGTINCom"]


        @codigo_gtin_unidad_inventario  = @xml_hash["gCodItem"]["dGTINInv"]
        @cantidad_gtin_unidad_inventario  = @xml_hash["gCodItem"]["dCantComInvent"] 

        #6.5.3. Grupo de ITBMS del Ítem
        @tasa_itbms  =  @xml_hash["gITBMSItem"]["dTasaITBMS"]
        @monto_itbms  = @xml_hash["gITBMSItem"]["dValITBMS"]
        
        #6.5.4. Grupo de ISC del Ítem
        @tasa_isc  = @xml_hash["gISCItem"]["dTasaISC"]
        @monto_isc  = @xml_hash["gISCItem"]["dValISC"]

        #6.5.5. Grupo de Otras Tasas o Impuestos (OTI) del Ítem
       # @tasa_otro_impuesto  = @xml_hash["gOTIItem"]["dCodOTI"]
       # @monto_otro_impuesto  = @xml_hash["gOTIItem"]["dValOTI"]
       lista_otros_impuestos = Pac::FacturaElectronica::ItemOtroImpuesto.listar(@xml_hash)


        @complemento_vehiculo_nuevo = Pac::FacturaElectronica::CampoComplementario::VehiculoNuevo.new(@xml_hash["gVehicNuevo"])
        @complemento_vehiculo_nuevo.cargar()

        @complemento_medicina = Pac::FacturaElectronica::CampoComplementario::Medicina.new(@xml_hash["gMedicina"])
        @complemento_medicina.cargar()

        @complemento_pedido_comercial_relacionado_item= Pac::FacturaElectronica::CampoComplementario::InformacionPedidoComercialItem.new(@xml_hash["gPedComIr"])
        @complemento_pedido_comercial_relacionado_item.cargar()


    end 
end 