class  Pac::Lote::Lote
    attr_accessor :version_del_formato # dVerForm
    attr_accessor :identificador_para_firma_electronica # dId
    attr_accessor :ambiente_destino # iAmb
    attr_accessor :facturas
    attr_accessor :xml_recep_lote_fe
    attr_accessor :xml_hash

    def initialize(xml_recep_lote_fe)
        @xml_recep_lote_fe = xml_recep_lote_fe
        @xml_hash =  Hash.from_xml(xml_recep_lote_fe)
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
        @version_del_formato = @xml_hash["rEnviLoteFe"]["dVerForm"]
        @identificador_para_firma_electronica = @xml_hash["rEnviLoteFe"]["dId"]
        @ambiente_destino = @xml_hash["rEnviLoteFe"]["iAmb"].to_i if @xml_hash["rEnviLoteFe"]["iAmb"].present?
        @facturas = []
        @xml_hash["rEnviLoteFe"]["xFe"].each do |factura|
            factura  = Pac::FacturaElectronica::FacturaElectronica.new(factura)
            factura.cargar
            @facturas << factura
        end 
        true
    rescue Exception => e
        p e.backtrace
        p e.message
    end

end