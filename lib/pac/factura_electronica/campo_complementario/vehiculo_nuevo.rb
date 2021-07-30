class Pac::FacturaElectronica::CampoComplementario::VehiculoNuevo
    attr_accessor :xml_hash
    attr_accessor :mod_operacion_vta_veh_nuevo # iModOpVN
    attr_accessor :mod_operacion_vta_veh_nuevo_no_listado # dModOpVNDesc
    attr_accessor :chasis # dChasi
    attr_accessor :color # dColorCod
    attr_accessor :desc_color # dColorNomb
    attr_accessor :potencia # dPotVeh
    attr_accessor :capacidad_motor # dCilin
    attr_accessor :peso_neto # dPesoNet
    attr_accessor :peso_bruto # dPesoBruto
    attr_accessor :mod_operacion_vta_veh_nuevo # iCombust
    attr_accessor :tipo_combustible # dCombustDesc
    attr_accessor :tipo_combustible_no_listado # dNroMotor
    attr_accessor :numero_motor # dCapTracc
    attr_accessor :cap_max_traccion # dEntreEj
    attr_accessor :distancia_ejes # dEntreEj
    attr_accessor :aaaa_mod_fabricacion # dAnoMod
    attr_accessor :aaaa_fabricacion # dAnoFab
    attr_accessor :tipo_pintura # iTipoPintura
    attr_accessor :tipo_pintura_no_listada # dTipoPinturaDesc
    attr_accessor :tipo # cTipoVehic
    attr_accessor :uso # cUsoVehic
    attr_accessor :condicion # iCondVehic
    attr_accessor :cap_max_pasajeros # dLotac

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
        @tipo_pintura = @xml_hash["iTipoPintura"]
        @tipo_pintura_no_listada = @xml_hash["dTipoPinturaDesc"]
        @tipo = @xml_hash["cTipoVehic"]
        @uso = @xml_hash["cUsoVehic"]
        @condicion = @xml_hash["iCondVehic"]
        @cap_max_pasajeros = @xml_hash["dLotac"]
    end

end