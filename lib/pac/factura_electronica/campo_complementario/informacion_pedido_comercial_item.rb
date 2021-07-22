class Pac::FacturaElectronica::CampoComplementario::InformacionPedidoComercialItem
    attr_accessor :numero_pedido # dNroPed
    attr_accessor :numero_item # dSecItemPed
    attr_accessor :informacion # dInfEmPedIt


    def initialize(xml_hash)
        @xml_hash = xml_hash        
    end


    def cargar
        @numero_pedido =@xml_hash["dNroPed"]
        @numero_item = @xml_hash["dSecItemPed"]
        @informacion = @xml_hash["dInfEmPedIt"]
    end

end