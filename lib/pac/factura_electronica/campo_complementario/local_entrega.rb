class Pac::FacturaElectronica::CampoComplementario::LocalEntrega
    attr_accessor :xml_hash
    attr_accessor :tipo_contribuyente # dTipoRuc
    attr_accessor :ruc # dRuc
    attr_accessor :dv_ruc # dDV
    attr_accessor :razon_social # dNombLcEntr F252
    attr_accessor :direccion_local # dDirecLcEntr F253
    attr_accessor :codigo_ubicacion # dCodUbi  F2541 
    attr_accessor :corregimiento # dCorreg F2542 
    attr_accessor :distrito # dDistr  F2543
    attr_accessor :provincia # dProv  F2544
    attr_accessor :telefono # dTfnLcEntr   F257
    attr_accessor :telefono_adicional # dTfnAdLcEntr  F258

    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def cargar
        @tipo_contribuyente = @xml_hash["gRucLcEntr"]["dTipoRuc"]
        @ruc = @xml_hash["gRucLcEntr"]["dRuc"]
        @dv_ruc = @xml_hash["gRucLcEntr"]["dDV"]

        @razon_social = @xml_hash["dNombLcEntr"]
        @direccion_local = @xml_hash["dDirecLcEntr"]

        @codigo_ubicacion = @xml_hash["gUbiLcEntr"]["dCodUbi"]
        @corregimiento = @xml_hash["gUbiLcEntr"]["dCorreg"]
        @distrito = @xml_hash["gUbiLcEntr"]["dDistr"]
        @provincia = @xml_hash["gUbiLcEntr"]["dProv"]

        @telefono = @xml_hash["dTfnLcEntr"]
        @telefono_adicional = @xml_hash["dTfnAdLcEntr"]
    end
    
end