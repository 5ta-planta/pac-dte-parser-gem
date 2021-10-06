
class Pac::FacturaElectronica::FirmaElectronica


    attr_accessor :signed_info
    attr_accessor :signature_value
    attr_accessor :firma_electronica


    def initialize(firma_electronica)
        @signature = firma_electronica
    end 


    def cargar
        puts "*************************************************************************************************************CARGAANDO LOA FIRMA ELECTRONICA*************************************************************************************************************"
        signed_info = SignedInfo.new
        signed_info.cargar
    end



end




 class SignedInfo
     attr_accessor :canonicalization_method
     attr_accessor :signature_method
     attr_accessor :reference

     def cargar
        puts "*************************************************************************************************************CARGAANDO LOA FIRMA ELECTRONICA signed infor*************************************************************************************************************"
         reference = Reference.new
     end

 end

 class Reference
     attr_accessor :transforms
     attr_accessor :digest_method
     attr_accessor :digest_value
 end