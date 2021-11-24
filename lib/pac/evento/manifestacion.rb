##Clase para representar una anulación
##
#
class Pac::Evento::Manifestacion
    
    attr_accessor :version_del_formato # dVerForm
    attr_accessor :identificador_para_firma_electronica # dIdFirma
    attr_accessor :ambiente_destino # iAmb
    attr_accessor :codigo_factura_manifestacion #dCufe 
    attr_accessor :ruc_contribuyente_receptor #dRucRec 
    attr_accessor :codigo_evento_manifestacion #dManifRecep
    attr_accessor :motivo_manifestacion #dMotManif

    attr_accessor :firma_electronica #Signature

    attr_accessor :resultado_validacion    
    attr_accessor :xml_hash
    attr_accessor :json #data source, texto (json o xml o cualquier otra cosa)
    attr_accessor :header 
    ##
    #
    def initialize(xml_manifestacion)
        self.xml_hash =  Hash.from_xml(xml_manifestacion)
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
        cargar_firma_electronica()
        true
    rescue Exception => e
        p e.backtrace
        p e.message
    end

    ##Metodo que carga datos relacionados con firma electronica
    ##6.9. Información de la Firma Electrónica de la FE
    #
    def cargar_firma_electronica
        @firma_electronica =  Pac::FacturaElectronica::FirmaElectronica.new(@xml_hash["rEvManifRecep"]) # @xml_hash["rFE"]["Signature"]
        @firma_electronica.cargar
    end


    ##Metodo que carga los datos complementarios de la factura electronica de uso general
    ##6.8. Campos Complementarios de Uso Comercial General
    #
    def cargar_datos_generales
        @version_del_formato = @xml_hash["rEvManifRecep"]["dVerForm"]
        @identificador_para_firma_electronica = @xml_hash["rEvManifRecep"]["gInfProt"]["dIdFirma"]
        @ambiente_destino = @xml_hash["rEvManifRecep"]["gInfProt"]["iAmb"].to_i if @xml_hash["rEvManifRecep"]["gInfProt"]["iAmb"].present?
        @codigo_factura_manifestacion = @xml_hash["rEvManifRecep"]["gInfProt"]["dCufe"] if @xml_hash["rEvManifRecep"]["gInfProt"]["dCufe"].present?
        @ruc_contribuyente_receptor = @xml_hash["rEvManifRecep"]["gInfProt"]["dRucRec"] if @xml_hash["rEvManifRecep"]["gInfProt"]["dRucRec"].present?
        @codigo_evento_manifestacion = @xml_hash["rEvManifRecep"]["gInfProt"]["dManifRecep"] if @xml_hash["rEvManifRecep"]["gInfProt"]["dManifRecep"].present?
        @motivo_manifestacion = @xml_hash["rEvManifRecep"]["gInfProt"]["dMotManif"] if @xml_hash["rEvManifRecep"]["gInfProt"]["dMotManif"].present?
                
        
    end

end

