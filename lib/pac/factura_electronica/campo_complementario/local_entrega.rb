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
        @tipo_contribuyente = nil
        @ruc = nil
        @dv_ruc = nil
        @razon_social = nil
        @direccion_local =  nil
        @codigo_ubicacion = nil
        @corregimiento = nil
        @distrito = nil
        @provincia = nil
        @telefono = nil
        @telefono_adicional = nil

    end

    def cargar

        if @xml_hash["gRucLcEntr"].present?
            @tipo_contribuyente = @xml_hash["gRucLcEntr"]["dTipoRuc"]
            @ruc = @xml_hash["gRucLcEntr"]["dRuc"]
            @dv_ruc = @xml_hash["gRucLcEntr"]["dDV"]
        end

        @razon_social = @xml_hash["dNombLcEntr"]
        @direccion_local = @xml_hash["dDirecLcEntr"]

        if @xml_hash["gUbiLcEntr"].present?
            @codigo_ubicacion = @xml_hash["gUbiLcEntr"]["dCodUbi"]
            @corregimiento = @xml_hash["gUbiLcEntr"]["dCorreg"]
            @distrito = @xml_hash["gUbiLcEntr"]["dDistr"]
            @provincia = @xml_hash["gUbiLcEntr"]["dProv"]
        end

        @telefono = @xml_hash["dTfnLcEntr"]
        @telefono_adicional = @xml_hash["dTfnAdLcEntr"]
    end
    
end