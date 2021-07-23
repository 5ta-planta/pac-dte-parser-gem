class Pac::FacturaElectronica::Cufe
    attr_accessor :cufe_a_validar
    attr_accessor :cufe
    attr_accessor :tipo_documento
    attr_accessor :tipo_contribuyente
    attr_accessor :ruc_del_emisor
    attr_accessor :dv_rc
    attr_accessor :codigo_sucursal
    attr_accessor :fecha_emision
    attr_accessor :numero_factura
    attr_accessor :punto_facturacion
    attr_accessor :tipo_de_emision
    attr_accessor :ambiente_destino
    attr_accessor :secuencia_seguridad
    attr_accessor :dv_cufe

    def initialize(cufe_a_validar)
        @cufe_a_validar = cufe_a_validar
    end 


    def cargar
        @cufe = cufe_a_validar.remove("FE")
        @tipo_documento = cufe[0..1]
        @tipo_contribuyente = cufe[2..2]
        @ruc_del_emisor = cufe[3..22]
        @dv_rc = cufe[23..25]
        @codigo_sucursal = cufe[26..29]
        @fecha_emision = cufe[30..37].to_time
        @numero_factura = cufe[38..47]
        @punto_facturacion = cufe[48..50]
        @tipo_de_emision = cufe[51..52]
        @ambiente_destino = cufe[53..53]
        @secuencia_seguridad = cufe[54..62]
        @dv_cufe = cufe[63..63]
    end


    def ping 
        p cufe
        p tipo_documento
        p tipo_contribuyente
        p ruc_del_emisor
        p dv_rc
        p codigo_sucursal
        p fecha_emision
        p numero_factura
        p punto_facturacion
        p tipo_de_emision
        p ambiente_destino
        p secuencia_seguridad
        p dv_cufe
    end


    def obtener_digito_validador(cufe)
        cufe_sin_dv= cufe[0...cufe.length-1]
        acumulado = 0 
        respuesta = 0
        cufe_sin_dv.reverse.to_s.chars.each_with_index   do |char,i|
            #validar si el char es una letra
            char = numerizar_segun_dgi(char)
            j = i + 1
            impar =  j.odd?
            multiplicacion =  impar ? char.to_i * 2 : char.to_i * 1            
            acumulado+= multiplicacion.to_s.length > 1 ? multiplicacion.to_s[0].to_i + multiplicacion.to_s[1].to_i : multiplicacion.to_s[0].to_i
        end
        resto = acumulado % 10 
        division = (acumulado / 10).to_i
        respuesta  = resto != 0 ? 10 -  resto : division
        return respuesta
    end


    def numerizar_segun_dgi(char)
        code = char.ord
        if (48 <= code && code <= 57)
            return char
        else
            return char.ord.to_s[1]
        end
    end


    def digito_verificador_cufe_es_valido?
        @dv_cufe == obtener_digito_validador(@cufe).to_s
    end 

    def ya_existe?
        return true
    end

end 