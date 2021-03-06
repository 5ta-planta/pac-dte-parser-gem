require "base64"
class Pac::Recepcion::Lote

    attr_accessor :version_del_formato,
    :dId,
    :ambiente,
    :lote,
    :facturas,
    :certificado,
    :servicio,
    :xml_facturas,
    :xml_validacion_firmas,
    :formato_entrada,
    :ruc_transmisor

    def initialize(lote)
        if is_json_valid?(lote)
            self.lote = JSON.parse(lote)
            self.formato_entrada = 'json'
        else
            self.lote = Base64.decode64(lote)
            self.formato_entrada = 'xml'
        end
    end

    def cargar
        self.facturas                = []
        self.xml_facturas            = []
        self.xml_validacion_firmas   = []
        if self.formato_entrada == 'json'
            xml_facturas = procesar_json
        else
            xml_facturas = procesar_xml
        end
        documento = Nokogiri::XML(xml_facturas)
        documento.xpath("//rFE").each do |factura|
            factura_parse = Pac::FacturaElectronica::FacturaElectronica.new(factura.to_xml(save_with: 0))
            factura_parse.cargar
            self.facturas << factura_parse
            self.xml_facturas << factura.to_xml(save_with: 0)
            factura.at("gNoFirm").remove
            self.xml_validacion_firmas << factura.to_xml(save_with: 0)
        end

    end

    def identificador_lote
        time = Time.now.year.to_s
        anio = time[2..3]
        identificador = Time.now.strftime("%H%M%S%3N")
        did = self.dId[-4..-1]
        "#{anio}#{did}#{identificador}"
    end


    private
    def procesar_json
        self.version_del_formato = self.lote["dVerForm"]
        self.dId                 = self.lote["dId"]
        self.ambiente            = self.lote["iAmb"]
        xFe                      = Base64.decode64(self.lote["xFe"])
        array_facturas           = "<root>#{xFe}</root>"
    end

    def procesar_xml
        xml = Nokogiri::XML(self.lote)
        self.version_del_formato = xml.at("dVerForm").content
        self.dId                 = xml.at("dId").content
        self.ambiente            = xml.at("iAmb").content
        array_facturas           = "<root>#{xml.at("xFe").content}</root>"
    end

    def is_json_valid?(valor)
        resultado = JSON.parse(valor)
        resultado.is_a?(Hash) || resultado.is_a?(Array)
    rescue JSON::ParserError, TypeError
        false
    end

end