
class Pac::FacturaElectronica::FirmaElectronica
    attr_accessor :firma_electronica
    attr_accessor :signed_info
    attr_accessor :signature_value
    attr_accessor :key_info
    attr_accessor :signature

    def initialize(firma_electronica)
       # self.signature = firma_electronica
       self.signed_info = SignedInfo.new(firma_electronica["Signature"]["SignedInfo"])
       self.key_info  = X09Data.new(firma_electronica["Signature"]["KeyInfo"])
       self.signed_info.cargar
       self.key_info.cargar
       self.signature_value = firma_electronica["Signature"]["SignatureValue"].strip
    end 


    def cargar
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
        self.x509_certificate = key_info["X509Data"]["X509Certificate"].strip
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
     attr_accessor :uri

     def initialize(reference)
        self.reference = reference
        self.transforms = []
     end

     def cargar
        
        if self.reference["Transforms"]["Transform"].count > 1
            self.reference["Transforms"]["Transform"].each do |t|
                self.transforms << {transform:t}
            end 
        else
            if (self.reference["Transforms"]["Transform"].count == 1)
                self.transforms << {transform: self.reference["Transforms"]["Transform"]}
            end

        end

        self.digest_method = self.reference["DigestMethod"]
        self.digest_value = self.reference["DigestValue"]
        self.uri =  self.reference["URI"]
     end
 end