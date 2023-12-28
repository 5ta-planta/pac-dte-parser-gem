class Pac::ProtocoloAutorizacion::AutorizacionPac
  attr_accessor :ambiente, 
    :version_aplicacion, 
    :version_formato, 
    :did, 
    :cufe,
    :fecha_procesamiento,
    :protocolo_autorizacion,
    :digest_value_firma,
    :respuesta_procesamiento,
    :xml,
    :xml_hash

  def initialize(protocolo_autorizacion_xml)
    xml_decode = Base64.decode64(protocolo_autorizacion_xml)
    self.xml = Nokogiri::XML(xml_decode).to_xml
    self.xml_hash =  Hash.from_xml(self.xml)
    self.respuesta_procesamiento = []
  end

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

  def cargar
    self.version_formato = xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['dVerForm'] || nil
    self.did = xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['dId'] || nil
    self.ambiente = xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['iAmb'] || nil
    self.version_aplicacion = xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['dVerApl'] || nil
    self.cufe = xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['dCUFE'] || nil
    self.fecha_procesamiento = xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['dFecProc'] || nil
    self.protocolo_autorizacion = xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['dProtAut'] || nil
    self.digest_value_firma = xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['dDigVal'] || nil
    if xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['gResProc'].is_a?(Array)
      xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['gResProc'].each do |respuesta|
        respuesta_procesamiento << {
          codigo: respuesta['dCodRes'],
          mensaje: respuesta['dMsgRes']
        }
      end
    else
      respuesta_procesamiento << {
        codigo: xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['gResProc']['dCodRes'],
        mensaje: xml_hash['rRetEnviFe']['xProtFe']['rProtFe']['gInfProt']['gResProc']['dMsgRes']
      }
    end
  end

end