class Pac::Recepcion::Fe

    attr_accessor :xml,
    :xml_xfe,
    :certificado,
    :servicio,
    :factura,
    :xml_validar_firma

    def initialize(datos)
        mensaje = JSON.parse(datos)
        self.xml = Base64.decode64(mensaje["feDatosMsg"])
    end 

    def cargar
        xml = Nokogiri::XML.parse(self.xml)
        xml_factura = xml.at("xFe").content
        factura = Pac::FacturaElectronica::FacturaElectronica.new(xml_factura)
        factura.cargar
        self.factura = factura
        self.xml_xfe = xml_factura
        xml_validacion_firma = Nokogiri::XML(xml_factura)
        xml_validacion_firma.at("gNoFirm").remove
        self.xml_validar_firma = xml_validacion_firma.root.to_xml(save_with: 0)

    end



end