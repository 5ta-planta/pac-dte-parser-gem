class Pac::Recepcion::Ev

    attr_accessor :version_del_formato,
        :dId,
        :ambiente,
        :xml,
        :xml_evento,
        :certificado,
        :servicio,
        :anulacion,
        :manifestacion,
        :xml_validar_firma,
        :formato_entrada,
        :tipo

    def initialize(evento)
        if is_json_valid?(evento)
            self.xml = JSON.parse(evento)
            self.formato_entrada = 'json'
        else
            xml_decode = Base64.decode64(evento)
            self.xml = Nokogiri::XML(xml_decode)
            self.formato_entrada = 'xml'
        end
    end 

    def cargar
        if self.formato_entrada == 'json'
            xml_evento = procesar_json
        else
            xml_evento = procesar_xml
            
        end
        #carga según tipo de ejemplo
        if xml_evento.include? "rEvAnulaFe" 
            self.tipo = "anulacion"
            anulacion = Pac::Evento::Anulacion.new xml_evento
            anulacion.cargar
            self.anulacion = anulacion
        else 
            self.tipo = "manifestacion"
            manifestacion = Pac::Evento::Manifestacion.new xml_evento
            manifestacion.cargar
            self.manifestacion = manifestacion
        end
        self.xml_evento = xml_evento
    end


    private

    def procesar_json
        self.version_del_formato = self.xml["dVerForm"]
        self.dId                 = self.xml["dId"]
        self.ambiente            = self.xml["iAmb"]
        return Base64.decode64(self.xml["dEvReg"])
        
    end

    def procesar_xml
        self.version_del_formato = xml.at("dVerForm").content
        self.dId                 = xml.at("dId").content
        self.ambiente            = xml.at("iAmb").content
        return xml.at("dEvReg").content
    end

    def is_json_valid?(valor)
        resultado = JSON.parse(valor)
        resultado.is_a?(Hash) || resultado.is_a?(Array)
    rescue JSON::ParserError, TypeError
        false
    end

end