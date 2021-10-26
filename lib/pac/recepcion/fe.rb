class Pac::Recepcion::Fe

    attr_accessor :version_del_formato,
    :dId,
    :ambiente,
    :xml,
    :xml_xfe,
    :certificado,
    :servicio,
    :factura,
    :xml_validar_firma,
    :formato_entrada

    def initialize(rfe)
        if is_json_valid?(rfe)
            self.xml = JSON.parse(rfe)
            self.formato_entrada = 'json'
        else
            xml_decode = Base64.decode64(rfe)
            self.xml = Nokogiri::XML(xml_decode)
            self.formato_entrada = 'xml'
        end
    end 

    def cargar
        if self.formato_entrada == 'json'
            xml_factura = procesar_json
        else
            xml_factura = procesar_xml
        end
        factura = Pac::FacturaElectronica::FacturaElectronica.new(xml_factura)
        factura.cargar
        self.factura = factura
        self.xml_xfe = xml_factura
        xml_validacion_firma = Nokogiri::XML(xml_factura)
        xml_validacion_firma.at("gNoFirm").remove
        self.xml_validar_firma = xml_validacion_firma.root.to_xml(save_with: 0)
    end


    private

    def procesar_json
        self.version_del_formato = self.xml["dVerForm"]
        self.dId                 = self.xml["dId"]
        self.ambiente            = self.xml["iAmb"]
        xFe                      = Base64.decode64(self.xml["xFe"])
        
    end

    def procesar_xml
        self.version_del_formato = xml.at("dVerForm")
        self.dId                 = xml.at("dId")
        self.ambiente            = xml.at("iAmb")
        xFe                      = xml.at("xFe").content
    end

    def is_json_valid?(valor)
        resultado = JSON.parse(valor)
        resultado.is_a?(Hash) || resultado.is_a?(Array)
    rescue JSON::ParserError, TypeError
        false
    end

end