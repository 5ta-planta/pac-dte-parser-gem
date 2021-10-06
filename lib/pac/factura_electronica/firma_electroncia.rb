class Pac::FacturaElectronica::FirmaElectronica


    attr_accessor :signed_info
    attr_accessor :signature_value
    attr_accessor :firma_electronica

    def initialize(firma_electronica)
        @signature = firma_electronica
    end 


    def cargar
#        signed_info = SignedInfo.new

    end

    


end




# class SignedInfo
#     attr_accessor :canonicalization_method
#     attr_accessor :signature_method
#     attr_accessor :reference

#     def cargar
#         reference = Reference.new
#     end

# end

# class Reference
#     attr_accessor :transforms
#     attr_accessor :digest_method
#     attr_accessor :digest_value
# end

 