class Pac::FacturaElectronica::CampoComplementario::Logistica
    attr_accessor :xml_hash
    attr_accessor :numero_volumenes # dNroVols
    attr_accessor :peso_total_carga # dPesoTot
    attr_accessor :unidad_peso_total_carga # dUnPesoTot
    attr_accessor :licencia_vehiculo_carga # dLicCamion
    attr_accessor :nombre_transportista # dNomTransp
    
    attr_accessor :tipo_contribuyente_transportista # dTipoRuc
    attr_accessor :ruc_transportista # dRuc
    attr_accessor :dv_ruc_transportista # dDV
    attr_accessor :informacion # dInfEmLog


    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def cargar
        @numero_volumenes = @xml_hash["dNroVols"]
        @peso_total_carga = @xml_hash["dPesoTot"]
        @unidad_peso_total_carga = @xml_hash["dUnPesoTot"]
        @licencia_vehiculo_carga = @xml_hash["dLicCamion"]
        @nombre_transportista = @xml_hash["dNomTransp"]
        @tipo_contribuyente_transportista = @xml_hash["gRucTransp"]["dTipoRuc"]
        @ruc_transportista = @xml_hash["gRucTransp"]["dRuc"]
        @dv_ruc_transportista = @xml_hash["gRucTransp"]["dDV"]
        @informacion = @xml_hash["gRucTransp"]["dInfEmLog"]
    end

end