class Pac::FacturaElectronica::CampoComplementario::VehiculoNuevo
    attr_accessor :xml_hash
    attr_accessor :mod_operacion_vta_veh_nuevo # iModOpVN  E050
    attr_accessor :mod_operacion_vta_veh_nuevo_no_listado # dModOpVNDesc E051
    attr_accessor :chasis # dChasi E052
    attr_accessor :color # dColorCod E053
    attr_accessor :desc_color # dColorNomb E054
    attr_accessor :potencia # dPotVeh E055
    attr_accessor :capacidad_motor # dCilin E056
    attr_accessor :peso_neto # dPesoNet E057
    attr_accessor :peso_bruto # dPesoBruto E058
    
    attr_accessor :tipo_combustible # iCombust E060
    attr_accessor :tipo_combustible_no_listado # dCombustDesc E061
    attr_accessor :numero_motor # dNroMotor E062
    attr_accessor :cap_max_traccion # dCapTracc E063
    attr_accessor :distancia_ejes # dEntreEj E064
    attr_accessor :aaaa_mod_fabricacion # dAnoMod E065
    attr_accessor :aaaa_fabricacion # dAnoFab E067
    attr_accessor :tipo_pintura # iTipoPintura E068
    attr_accessor :tipo_pintura_no_listada # dTipoPinturaDesc E069
    attr_accessor :tipo # cTipoVehic E070
    attr_accessor :uso # cUsoVehic E071
    attr_accessor :condicion # iCondVehic E072
    attr_accessor :cap_max_pasajeros # dLotac E073

    def initialize(xml_hash)
        @xml_hash = xml_hash        
    end


    def cargar
        @mod_operacion_vta_veh_nuevo = @xml_hash["iModOpVN"]
        @mod_operacion_vta_veh_nuevo_no_listado = @xml_hash["dModOpVNDesc"]
        @chasis = @xml_hash["dChasi"]
        @color = @xml_hash["dColorCod"]
        @desc_color = @xml_hash["dColorNomb"]
        @potencia = @xml_hash["dPotVeh"]
        @capacidad_motor = @xml_hash["dCilin"]
        @peso_neto = @xml_hash["dPesoNet"]
        @peso_bruto = @xml_hash["dPesoBruto"]
        @tipo_combustible = @xml_hash["iCombust"]
        @tipo_combustible_no_listado = @xml_hash["dCombustDesc"]
        @numero_motor = @xml_hash["dNroMotor"]
        @cap_max_traccion = @xml_hash["dCapTracc"]
        @distancia_ejes = @xml_hash["dEntreEj"]
        @aaaa_mod_fabricacion = @xml_hash["dAnoMod"]
        @aaaa_fabricacion = @xml_hash["dAnoFab"]
        @tipo_pintura = @xml_hash["iTipoPintura"].to_i
        @tipo_pintura_no_listada = @xml_hash["dTipoPinturaDesc"]
        @tipo = @xml_hash["cTipoVehic"].to_i
        @uso = @xml_hash["cUsoVehic"]
        @condicion = @xml_hash["iCondVehic"].to_i
        @cap_max_pasajeros = @xml_hash["dLotac"]
    end

end