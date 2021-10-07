
class Pac::FacturaElectronica::FirmaElectronica
    attr_accessor :firma_electronica
    attr_accessor :signed_info
    attr_accessor :signature_value
    attr_accessor :key_info
    attr_accessor :signature

    def initialize(firma_electronica)
        self.signature = firma_electronica
    end 


    def cargar
        puts "************************************************************************12121*************************************CARGAANDO LOA FIRMA ELECTRONICA*************************************************************************************************************"
        self.signed_info = SignedInfo.new(self.signature["Signature"]["SignedInfo"])
        self.key_info  = X09Data.new(self.signature["Signature"]["KeyInfo"])
        self.signed_info.cargar
        self.key_info.cargar
        self.signature_value = self.signature["Signature"]["SignatureValue"]
    end
end

class X09Data
    attr_accessor :x509_subject_name
    attr_accessor :x509_certificate
    attr_accessor :key_info

    def initialize(key_info)
        self.key_info = key_info
    end

    def cargar
        self.x509_certificate = key_info["X509Data"]["X509Certificate"]
        self.x509_subject_name = key_info["X509Data"]["X509SubjectName"]
    end

end


 class SignedInfo
     attr_accessor :canonicalization_method
     attr_accessor :signature_method
     attr_accessor :reference
     attr_accessor :signed_info

    def initialize(info)
        self.signed_info = info
    end

    def cargar
        self.canonicalization_method = self.signed_info["CanonicalizationMethod"]
        self.signature_method = self.signed_info["SignatureMethod"]
        self.reference = Reference.new(self.signed_info["Reference"])
        self.reference.cargar
    end

 end

 class Reference
     attr_accessor :transforms
     attr_accessor :digest_method
     attr_accessor :digest_value
     attr_accessor :reference

     def initialize(reference)
        self.reference = reference
        self.transforms = []
     end

     def cargar
        byebug
        if self.reference["Transforms"]["Transform"].count > 1
            self.reference["Transforms"]["Transform"].each do |t|
                self.transforms << {transform:t["Transform"]}
            end 
        else
            if (self.reference["Transforms"]["Transform"].count == 1)
                self.transforms << {transform:t["Transform"][0]}
            end

        end

        self.digest_method = self.reference["DigestMethod"]
        self.digest_value = self.reference["DigestValue"]
     end
 end