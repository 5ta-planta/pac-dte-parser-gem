require "base64"
class Pac::Recepcion::Lote

    attr_accessor :xml_lote,
    :parse_facturas,
    :certificado,
    :servicio,
    :xml_facturas,
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

        self.parse_facturas          = []
        self.xml_facturas            = []
        self.xml_validacion_firmas   = []

        xml_lote = Base64.decode64(datos_mensaje["feDatosMsg"])

        xml = Nokogiri::XML(xml_lote)
        array_xml_facturas = "<root>#{xml.at("xFe").content}</root>"
        documento = Nokogiri::XML(array_xml_facturas)
        documento.xpath("//rFE").each do |factura|
            factura_parse = Pac::FacturaElectronica::FacturaElectronica.new(factura.to_xml(save_with: 0))
            factura_parse.cargar
            self.parse_facturas << factura_parse
            self.xml_facturas << factura.to_xml(save_with: 0)
            factura.at("gNoFirm").remove
            self.xml_validacion_firmas << factura.to_xml(save_with: 0)
        end
        
    end

end