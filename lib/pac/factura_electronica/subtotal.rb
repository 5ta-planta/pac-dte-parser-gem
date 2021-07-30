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
         
        @total_neto = @xml_hash["dTotNeto"].to_f if @xml_hash["dTotNeto"].present?
        @total_itbms = @xml_hash["dTotITBMS"].to_f if @xml_hash["dTotITBMS"].present?
        @total_isc = @xml_hash["dTotISC"].to_f if @xml_hash["dTotISC"].present?
        @total_gravado = @xml_hash["dTotGravado"].to_f if @xml_hash["dTotGravado"].present?
        @total_descuentos = @xml_hash["dTotDesc"].to_f if @xml_hash["dTotDesc"].present?
        @total_acarreo = @xml_hash["dTotAcar"].to_f if @xml_hash["dTotAcar"].present?
        @total_seguro = @xml_hash["dTotSeg"].to_f if @xml_hash["dTotSeg"].present?
        @total_factura = @xml_hash["dVTot"].to_f if @xml_hash["dVTot"].present?
        @suma_valores_recibidos = @xml_hash["dTotRec"].to_f if @xml_hash["dTotRec"].present?
        @vuelto = @xml_hash["dVuelto"].to_f if @xml_hash["dVuelto"].present?
        @tiempo_pago = @xml_hash["iPzPag"] if @xml_hash["iPzPag"].present?
        @numero_total_items = @xml_hash["dNroItems"].to_f if @xml_hash["dNroItems"].present?
        @total_items = @xml_hash["dVTotItems"].to_fif @xml_hash["dVTotItems"].present? 
    end


end

