class Pac::Lote::Lote
    attr_accessor :version_del_formato # dVerForm
    attr_accessor :identificador_para_firma_electronica # dId
    attr_accessor :ambiente_destino # iAmb
  
    attr_accessor :xml_recep_lote_fe

    attr_accessor :json #data source, texto (json o xml o cualquier otra cosa)
    attr_accessor :header 
    attr_accessor :xml_facturas

    def initialize(str_recep_lote_fe)
        byebug
        require 'json'
        self.header  = Pac::FacturaElectronica::Header.new
        self.json = str_recep_lote_fe
        mensaje = JSON.parse(self.json)
        self.header.dVerForm =mensaje["dVerForm"] # mensaje["dVerForm"]
        self.header.dId = mensaje["dId"]# mensaje["dId"]
        self.header.iAmb = mensaje["iAmb"] #mensaje["iAmb"]
        self.header.xFE =  Base64.decode64(mensaje["xFe"]) #mensaje["iAmb"] #Base64.decode64(mensaje["xFe"])
#       self.xml_factura = self.header.xFE
#       self.xml_hash =  Hash.from_xml(self.xml_factura)
        self.xml_facturas = Hash.from_xml(self.header.xFE)
 
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
        puts "Iniciando la carga del lote"

        self.facturas = []
        byebug
        self.facturas = self.xml_facturas["rFe"]

        self.facturas.each_with_index do |xfe,idx|
            puts "Mensaje para el team: Hay que ver si es necesario armar de nuevo del json de entrada.... "
            factura  = Pac::FacturaElectronica::FacturaElectronica.new(xfe.to_s)
            factura.cargar
            @facturas << factura
        end

   
    rescue Exception => e
        p e.backtrace
        p e.message
    end

end