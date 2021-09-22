class Pac::Lote::Lote
    attr_accessor :version_del_formato # dVerForm
    attr_accessor :identificador_para_firma_electronica # dId
    attr_accessor :ambiente_destino # iAmb
    attr_accessor :facturas
    attr_accessor :xml_recep_lote_fe

    def initialize(xml_recep_lote_fe)
        @xml_recep_lote_fe = xml_recep_lote_fe        
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
        parseXmlFe =  Nokogiri::XML::parse(@xml_recep_lote_fe)

        @version_del_formato = parseXmlFe.xpath("//feDatosMsg//dgi:rEnviLoteFe//dgi:dVerForm")[0].content.to_s
        @identificador_para_firma_electronica = parseXmlFe.xpath("//feDatosMsg//dgi:rEnviLoteFe//dgi:dId")[0].content.to_s
        @ambiente_destino = parseXmlFe.xpath("//feDatosMsg//dgi:rEnviLoteFe//dgi:iAmb")[0].content.to_s
        @facturas = []



        parseXmlFe.xpath("//dgi:xFe").each_with_index do |xfe,idx|
            puts "Procesando Factur no...................................................................................................#{idx}"
            p xfe.content.to_s
            factura  = Pac::FacturaElectronica::FacturaElectronica.new(xfe.content.to_s)
            factura.cargar
            @facturas << factura
        end

   
    rescue Exception => e
        p e.backtrace
        p e.message
    end

end