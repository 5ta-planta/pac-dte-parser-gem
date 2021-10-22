require "base64"
class Pac::Recepcion::Lote

    attr_accessor :xml_lote,
    :facturas,
    :certificado,
    :servicio

    def initialize(datos)
        mensaje = JSON.parse(datos)
        self.facturas = Array.new
        self.xml_lote = Base64.decode64(mensaje["feDatosMsg"])
        self.certificado = mensaje["certificado"] 
        self.servicio = mensaje["servicio"] 
    end

    def cargar

        xml = Nokogiri::XML.parse(self.xml_lote)
        array_xml_facturas = "<root>#{xml.at("xFe").content}</root>"
        documento = Nokogiri::XML(array_xml_facturas)
        documento.xpath("//rFE").each do |factura|
            factura_parse = Pac::FacturaElectronica::FacturaElectronica.new(factura.to_s)
            factura_parse.cargar
            self.facturas << factura_parse
        end
    end

end