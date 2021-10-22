class Pac::Recepcion::Fe

    attr_accessor :xml,
    :xml_xfe,
    :certificado,
    :servicio,
    :factura
    :xml_validar_firma

    def initialize(datos)
        mensaje = JSON.parse(datos)
        self.xml = Base64.decode64(mensaje["feDatosMsg"])
        self.certificado = mensaje["certificado"] 
        self.servicio = mensaje["servicio"] 
    end 

    def cargar
        xml = Nokogiri::XML.parse(self.xml)
        xml_factura = xml.at("//xFe").content
        factura = Pac::FacturaElectronica::FacturaElectronica.new(xml_factura.to_s)
        factura.cargar
        self.factura = factura
        self.xml_xfe = xml_factura
        xml_codigo_qr = Nokogiri::XML(xml_factura)
        xml_codigo_qr.at("//gNoFirm").remove
        self.xml_validar_firma = xml_codigo_qr.to_s

    end



end