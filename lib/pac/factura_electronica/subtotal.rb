class Pac::FacturaElectronica::Subtotal
    attr_accessor :xml_hash
    attr_accessor :total_neto # dTotNeto
    attr_accessor :total_itbms # dTotITBMS
    attr_accessor :total_isc # dTotISC
    attr_accessor :total_gravado # dTotGravado
    attr_accessor :total_descuentos # dTotDesc
    attr_accessor :total_acarreo # dTotAcar
    attr_accessor :total_seguro # dTotSeg
    attr_accessor :total_factura # dVTot
    attr_accessor :suma_valores_recibidos # dTotRec
    attr_accessor :vuelto # dVuelto
    attr_accessor :tiempo_pago # iPzPag
    attr_accessor :numero_total_items # dNroItems
    attr_accessor :total_items # dVTotItems

   # attr_accessor :lista_descuentos_bonificaciones_adicionales



    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def cargar()
         
        @total_neto = @xml_hash["dTotNeto"].to_f
        @total_itbms = @xml_hash["dTotITBMS"].to_f
        @total_isc = @xml_hash["dTotISC"].to_f
        @total_gravado = @xml_hash["dTotGravado"].to_f
        @total_descuentos = @xml_hash["dTotDesc"].to_f
        @total_acarreo = @xml_hash["dTotAcar"].to_f
        @total_seguro = @xml_hash["dTotSeg"].to_f
        @total_factura = @xml_hash["dVTot"].to_f
        @suma_valores_recibidos = @xml_hash["dTotRec"].to_f
        @vuelto = @xml_hash["dVuelto"].to_f
        @tiempo_pago = @xml_hash["iPzPag"]
        @numero_total_items = @xml_hash["dNroItems"].to_f
        @total_items = @xml_hash["dVTotItems"].to_f

      
 
    end


end

