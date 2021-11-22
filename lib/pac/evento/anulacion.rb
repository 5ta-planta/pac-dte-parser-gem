##Clase para representar una anulación
##
#
class Pac::Evento::Anulacion
    
    attr_accessor :version_del_formato # dVerForm
    attr_accessor :identificador_para_firma_electronica # dIdFirma
    attr_accessor :ambiente_destino # iAmb
    attr_accessor :codigo_factura_anular #dCufe 
    attr_accessor :emisor # Pac::FacturaElectronica::Emisor
    attr_accessor :motivo_anulacion # dMotivoAn
    attr_accessor :firma_electronica #Signature

    attr_accessor :resultado_validacion    
    attr_accessor :xml_hash
    attr_accessor :json #data source, texto (json o xml o cualquier otra cosa)
    attr_accessor :header 
    ##
    #
    def initialize(xml_anulacion)
        self.xml_hash =  Hash.from_xml(xml_anulacion)
    end


    #Auxiliar para obtener los campos de la anulación
     def campos
        json = JSON.parse self.xml_hash.to_json

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
        cargar_datos_generales()
        cargar_datos_emisor()
        cargar_firma_electronica()
        true
    rescue Exception => e
        p e.backtrace
        p e.message
    end

    def cargar_datos_emisor
        emisor_hash = @xml_hash["rEvAnulaFe"]["gInfProt"]["gRucEm"]
        @emisor = Pac::Evento::Emisor.new(emisor_hash)
        @emisor.cargar();
    end

    ##Metodo que carga datos relacionados con firma electronica
 
    def cargar_firma_electronica
        @firma_electronica =  Pac::FacturaElectronica::FirmaElectronica.new(@xml_hash["rEvAnulaFe"]) 
        @firma_electronica.cargar
    end

    ##Metodo que carga los datos complementarios de la factura electronica de uso general
 
    def cargar_datos_generales
        @version_del_formato = @xml_hash["rEvAnulaFe"]["dVerForm"]
        @identificador_para_firma_electronica = @xml_hash["rEvAnulaFe"]["gInfProt"]["dIdFirma"]

        @ambiente_destino = @xml_hash["rEvAnulaFe"]["gInfProt"]["iAmb"].to_i if @xml_hash["rEvAnulaFe"]["gInfProt"]["iAmb"].present?
        @codigo_factura_anular = @xml_hash["rEvAnulaFe"]["gInfProt"]["dCufe"] if @xml_hash["rEvAnulaFe"]["gInfProt"]["dCufe"].present?
        @motivo_anulacion = @xml_hash["rEvAnulaFe"]["gInfProt"]["dMotivoAn"] if @xml_hash["rEvAnulaFe"]["gInfProt"]["dMotivoAn"].present?
    end

end

