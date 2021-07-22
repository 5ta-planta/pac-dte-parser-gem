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
         
        @total_neto = @xml_hash["dTotNeto"]
        @total_itbms = @xml_hash["dTotITBMS"]
        @total_isc = @xml_hash["dTotISC"]
        @total_gravado = @xml_hash["dTotGravado"]
        @total_descuentos = @xml_hash["dTotDesc"]
        @total_acarreo = @xml_hash["dTotAcar"]
        @total_seguro = @xml_hash["dTotSeg"]
        @total_factura = @xml_hash["dVTot"]
        @suma_valores_recibidos = @xml_hash["dTotRec"]
        @vuelto = @xml_hash["dVuelto"]
        @tiempo_pago = @xml_hash["iPzPag"]
        @numero_total_items = @xml_hash["dNroItems"]
        @total_items = @xml_hash["dVTotItems"]

      
 
    end


end

