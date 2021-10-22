class Pac::Recepcion::Fe

    attr_accessor :xml_xfe,
    :certificado,
    :servicio,
    :factura
    

    def initialize(datos)
        mensaje = JSON.parse(datos)
        self.xml_xfe = Base64.decode64(mensaje["feDatosMsg"])
        self.certificado = mensaje["certificado"] 
        self.servicio = mensaje["servicio"] 
    end 

    def cargar
        xml = Nokogiri::XML.parse(self.xml_xfe)
        xml_factura = xml.at("xFe").content
        factura = Pac::FacturaElectronica::FacturaElectronica.new(xml_factura.to_s)
        factura.cargar
        self.factura = factura
    end



end