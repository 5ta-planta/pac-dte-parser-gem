class Pac::FacturaElectronica::PagoPlazo
    attr_accessor :xml_hash
    attr_accessor :numero_cuota    
    attr_accessor :fecha_vencimiento_cuota
    attr_accessor :valor_cuota
    attr_accessor :informacion
    
    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def self.listar(hash)
        lista_informacion_pago_plazo = []
        if(hash["rFE"]["gTot"]["gPagPlazo"].present?)
            if (hash["rFE"]["gTot"]["gPagPlazo"].class == Array)
                hash["rFE"]["gTot"]["gPagPlazo"].each do |pago_a_plazo|
                    nueva_informacion = Pac::FacturaElectronica::PagoPlazo.new( pago_a_plazo)
                    nueva_informacion.cargar();
                    lista_informacion_pago_plazo  << nuevo_descuento
                end
            else
                nueva_informacion = Pac::FacturaElectronica::PagoPlazo.new( hash["rFE"]["gTot"]["gPagPlazo"])
                nueva_informacion.cargar();
                lista_informacion_pago_plazo  << nuevo_descuento
            end 
        end
        return lista_informacion_pago_plazo
    end

    def cargar
        @numero_cuota = @xml_hash["dSecItem"]
        @fecha_vencimiento_cuota = @xml_hash["dFecItPlazo"]
        @valor_cuota = @xml_hash["dValItPlazo"].to_f if @xml_hash["dValItPlazo"].present?
        @informacion = @xml_hash["dInfPagPlazo"]
    end

end