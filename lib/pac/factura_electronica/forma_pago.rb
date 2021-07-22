class Pac::FacturaElectronica::FormaPago
    attr_accessor :xml_hash
    attr_accessor :forma_pago
    attr_accessor :descripcion_forma_pago_no_listada
    attr_accessor :valor_forma_pago

    def initialize(xml_hash)
        @xml_hash = xml_hash
    end

    def self.listar(hash)
        lista_formas_pago = []
        if (hash["rFE"]["gTot"]["gFormaPago"].present?)
            if (hash["rFE"]["gTot"]["gFormaPago"].class == Array)
                hash["rFE"]["gTot"]["gFormaPago"].each do |descuento_adicional|
                    nuevo_descuento = Pac::FacturaElectronica::FormaPago.new( descuento_adicional)
                    nuevo_descuento.cargar();
                    lista_formas_pago  << nuevo_descuento
                end
            else
                nuevo_descuento = Pac::FacturaElectronica::FormaPago.new( hash["rFE"]["gTot"]["gFormaPago"])
                nuevo_descuento.cargar();
                lista_formas_pago  << nuevo_descuento
            end 
        end
        return lista_formas_pago
    end

    def cargar
        @forma_pago = @xml_hash["iFormaPago"]
        @descripcion_forma_pago_no_listada = @xml_hash["dFormaPagoDesc"]
        @valor_cuota = @xml_hash["dVlrCuota"]
    end

end