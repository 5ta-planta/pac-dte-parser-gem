class Pac::FacturaElectronica::CampoComplementario::InformacionFactura
    attr_accessor :xml_hash
    attr_accessor :numero_pedido # dNroPed
    attr_accessor :numero_aceptacion # dNumAcept
    attr_accessor :codigo_receptor # dCodRec
    attr_accessor :codigo_sistema_emisor # dCodSisEm
    attr_accessor :informacion # dInfEmPedGl

    def initialize(xml_hash)
        @xml_hash = xml_hash
    end 

    def self.ping 
        puts "poing"
    end 

    def cargar()
        @numero_pedido =  @xml_hash["dNroPed"]
        @numero_aceptacion = @xml_hash["dNumAcept"]
        @codigo_receptor = @xml_hash["dCodRec"]
        @codigo_sistema_emisor = @xml_hash["dCodSisEm"]
        @informacion = @xml_hash["dInfEmPedGl"]
    end

end