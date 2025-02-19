class Pac::FacturaElectronica::Subtotal
    attr_accessor :xml_hash
    attr_accessor :total_neto # dTotNeto D02
    attr_accessor :total_itbms # dTotITBMS D03
    attr_accessor :total_isc # dTotISC D04
    attr_accessor :total_otra_tasa
    attr_accessor :total_gravado # dTotGravado D05
    attr_accessor :total_descuentos # dTotDesc D06
    attr_accessor :total_acarreo # dTotAcar D07
    attr_accessor :total_seguro # dTotSeg D08
    attr_accessor :total_factura # dVTot D09
    attr_accessor :suma_valores_recibidos # dTotRec D10
    attr_accessor :vuelto # dVuelto D11
    attr_accessor :tiempo_pago # iPzPag D12
    attr_accessor :numero_total_items # dNroItems dNroItems
    attr_accessor :total_items # dVTotItems D14
    attr_accessor :total_otros_gastos # dTotOtrosGastos D15

   # attr_accessor :lista_descuentos_bonificaciones_adicionales



    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def cargar()
        @total_isc = nil
        @total_descuentos = nil
        @total_acarreo = nil
        @total_seguro = nil
        @vuelto = nil
        
        @total_neto = @xml_hash["dTotNeto"].to_f            rescue 0
        @total_itbms = @xml_hash["dTotITBMS"].to_f          rescue 0
        
        if @xml_hash["dTotISC"].present?
            @total_isc = @xml_hash["dTotISC"].to_f              
        end

        @total_gravado = @xml_hash["dTotGravado"].to_f      rescue 0

        if @xml_hash["dTotDesc"].present?
            @total_descuentos = @xml_hash["dTotDesc"].to_f  
        end
        if @xml_hash["dTotAcar"].present?
            @total_acarreo = @xml_hash["dTotAcar"].to_f         
        end
        if @xml_hash["dTotSeg"].present?
            @total_seguro = @xml_hash["dTotSeg"].to_f  
        end         


        @total_factura = @xml_hash["dVTot"].to_f            rescue 0
        @suma_valores_recibidos = @xml_hash["dTotRec"].to_f rescue 0

     
        if @xml_hash["dVuelto"].present?
            @vuelto = @xml_hash["dVuelto"].to_f                 
        end

        @tiempo_pago = @xml_hash["iPzPag"].to_i             rescue 0
        @numero_total_items = @xml_hash["dNroItems"].to_i   rescue 0
        @total_items = @xml_hash["dVTotItems"].to_f         rescue 0
        @total_otros_gastos = @xml_hash["dTotOtrosGastos"].to_f   rescue 0
    end

    
end

