class Pac::FacturaElectronica::DescuentoAdicional
    attr_accessor :descripcion_descuentos_adicionales # dDetalDesc
    attr_accessor :monto_descuentos_adicionales # dValDesc


    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def self.listar(hash)
        lista_descuentos_bonificaciones_adicionales = []
        if (hash["rFE"]["gTot"]["gDescBonif"].present?)
            if (hash["rFE"]["gTot"]["gDescBonif"].class == Array)
                hash["rFE"]["gTot"]["gDescBonif"].each do |descuento_adicional|
                    nuevo_descuento = Pac::FacturaElectronica::DescuentoAdicional.new( descuento_adicional)
                    nuevo_descuento.cargar();
                    lista_descuentos_bonificaciones_adicionales  << nuevo_descuento
                end
            else
                nuevo_descuento = Pac::FacturaElectronica::DescuentoAdicional.new( hash["rFE"]["gTot"]["gDescBonif"])
                nuevo_descuento.cargar();
                lista_descuentos_bonificaciones_adicionales  << nuevo_descuento
            end
        end
        return lista_descuentos_bonificaciones_adicionales
    end

    def cargar
        @descripcion_descuentos_adicionales = @xml_hash["dDetalDesc"]
        @monto_descuentos_adicionales = @xml_hash["dValDesc"].to_f if @xml_hash["dValDesc"].present?
    end

end 