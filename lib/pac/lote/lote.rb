class Pac::Lote::Lote
    attr_accessor :version_del_formato # dVerForm
    attr_accessor :identificador_para_firma_electronica # dId
    attr_accessor :ambiente_destino # iAmb
  
    attr_accessor :xml_recep_lote_fe

    attr_accessor :json #data source, texto (json o xml o cualquier otra cosa)
    attr_accessor :header 
    attr_accessor :xml_facturas
    attr_accessor :certificado
    attr_accessor :servicio
    attr_accessor :facturas

    def initialize(str_recep_lote_fe)
        require 'json'
        self.header  = Pac::FacturaElectronica::Header.new
        self.json = str_recep_lote_fe
        mensaje = JSON.parse(self.json)
        self.header.dVerForm =mensaje["dVerForm"] 
        self.header.dId = mensaje["dId"]
        self.header.iAmb = mensaje["iAmb"] 
        
        self.header.xFE = "<xFe> #{Base64.decode64(mensaje["xFe"])} </xFe>" 

        self.xml_facturas = Hash.from_xml(self.header.xFE)
        self.facturas=[]
        self.certificado = mensaje["certificado"] 
        self.servicio = mensaje["servicio"] 
 
    end

    #Auxiliar para obtener los campos del DTE
    def campos
        json = JSON.parse self.to_json

        def agregar_llaves(keys, campo = 0)
        
        if keys.class.to_s == "String" or keys.class.to_s == "NilClass"
            puts "#{"-" * campo} #{keys.class}"
            return keys.class
        else
                keys.keys.each do |key|
                clase = keys[key].class.to_s               
                if key != "xml_hash"
                        if clase == "Hash"   
                            puts "#{"-" * campo} #{key}"                              
                            agregar_llaves(keys[key], campo + 1)
                        else                
                            if clase == "Array"                                                                         
                                puts "#{"-" * campo} #{key}"
                                elemento = keys[key].first                                                                                                                                        
                                agregar_llaves(elemento, campo + 1)
                            else                                                                      
                                puts "#{"-" * campo} #{key}"
                            end
                        end
                end
                end

            return  true
            end
        end
        agregar_llaves(json)
    end


    def cargar()
        require 'nokogiri'

        puts "Iniciando la carga del lote"
        doc = Nokogiri::XML(self.header.xFE)

        byebug
        doc.search('rFE').map do |listing|
            byebug
            puts listing
        end
            
        array = self.xml_facturas["xFe"]["rFE"]
        
        # array.each_with_index do | xfe, index |
        #     puts "Mensaje para el team: Hay que ver si es necesario armar de nuevo del json de entrada.... "
            
        #     byebug
        #    # factura_a_parsear = {"dVerForm":self.header.dVerForm,"dId":self.header.dId,"iAmb":self.header.iAmb ,"xFe":  Base64.encode64(xfe.to_json) ,"certificado": self.certificado,"servicio": self.servicio}

        #     factura  = Pac::FacturaElectronica::FacturaElectronica.new(xfe.to_json)
        #     factura.cargar
        #     self.facturas << factura
        # end

   
    rescue Exception => e
        p e.backtrace
        p e.message
    end

end