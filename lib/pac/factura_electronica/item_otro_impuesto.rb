class Pac::FacturaElectronica::ItemOtroImpuesto
    attr_accessor :xml_hash
    attr_accessor :tasa_otro_impuesto #dCodOTI
    attr_accessor :monto_otro_impuesto #dValOTI
   

    def initialize(xml_hash)
        @xml_hash = xml_hash
    end


    def self.listar(hash)
        lista_items = []
        if (hash["gOTIItem"].present?)
            if (hash["gOTIItem"].class == Array)
                hash["gOTIItem"].each_with_index do |item_hash, index|
                    item_factura =  Pac::FacturaElectronica::ItemOtroImpuesto.new(item_hash)
                    item_factura.cargar()
                    lista_items << item_factura
                end
            else
                item_factura =  Pac::FacturaElectronica::ItemOtroImpuesto.new(hash["gOTIItem"])
                item_factura.cargar()
                lista_items << item_factura
            end
        end

        return lista_items
    end 


    def cargar()
        @tasa_otro_impuesto = @xml_hash["dCodOTI"]
        @monto_otro_impuesto  = @xml_hash["dValOTI"] 
    end 


end