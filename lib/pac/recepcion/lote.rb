require "base64"
class Pac::Recepcion::Lote

    attr_accessor :xml_lote,
    :facturas,
    :certificado,
    :servicio,
    :xml_rfes,
    :xml_validacion_firmas

    def initialize(datos)
        mensaje = JSON.parse(datos)
        self.facturas = Array.new
        self.xml_rfes = Array.new
        self.xml_validacion_firmas = Array.new
        self.xml_lote = Base64.decode64(mensaje["feDatosMsg"])
        self.certificado = mensaje["certificado"] 
        self.servicio = mensaje["servicio"] 
    end

    def cargar

        xml = Nokogiri::XML.parse(self.xml_lote)
        array_xml_facturas = "<root>#{xml.at("xFe").content}</root>"
        documento = Nokogiri::XML(array_xml_facturas)
        documento.xpath("//rFE").each do |factura|
            factura_parse = Pac::FacturaElectronica::FacturaElectronica.new(factura)
            factura_parse.cargar
            self.facturas << factura_parse
            self.xml_rfes << factura
            xml_validacion_firma = Nokogiri::XML(factura)
            xml_validacion_firma.at("gNoFirm").remove
            xml_validacion_firma.root.to_xml(save_with: 0)
            self.xml_validacion_firmas << xml_validacion_firma
            xml_validacion_firma = nil
        end
    end

end