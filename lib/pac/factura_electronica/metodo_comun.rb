class Pac::FacturaElectronica::MetodoComun
    def self.registro_error(codigo, evento ='R')
        error = ERRORES_84[codigo]
        if error.present?
            return {id: error["id"] , resultado:error["resultado"] , codigo: codigo, evento: evento}
        else
            return nil
        end
    end 
end