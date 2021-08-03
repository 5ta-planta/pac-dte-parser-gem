require 'rails'
module Pac	     
	module FacturaElectronica		  
		autoload :FacturaElectronica, 'pac/factura_electronica/factura_electronica'
		autoload :Emisor, 'pac/factura_electronica/emisor'
		autoload :Cufe, 'pac/factura_electronica/cufe'
		autoload :DescuentoAdicional, 'pac/factura_electronica/descuento_adicional'
		autoload :DocumentoFiscalReferenciado, 'pac/factura_electronica/documento_fiscal_referenciado'
		autoload :Exportacion, 'pac/factura_electronica/exportacion'
		autoload :FormaPago, 'pac/factura_electronica/forma_pago'
		autoload :GrupoAutorizadoDescarga, 'pac/factura_electronica/grupo_autorizado_descarga'
		autoload :Item, 'pac/factura_electronica/item'
		autoload :ItemOtroImpuesto, 'pac/factura_electronica/item_otro_impuesto'
		autoload :MetodoComun, 'pac/factura_electronica/metodo_comun'
		autoload :PagoPlazo, 'pac/factura_electronica/pago_plazo'
		autoload :Receptor, 'pac/factura_electronica/receptor'
		autoload :Retencion, 'pac/factura_electronica/retencion'
		autoload :Subtotal, 'pac/factura_electronica/subtotal'
		autoload :TotalOtraTasa, 'pac/factura_electronica/total_otra_tasa'
		module CampoComplementario
			autoload :InformacionFactura, 'pac/factura_electronica/campo_complementario/informacion_factura' 

			autoload :InformacionPedidoComercialItem, 'pac/factura_electronica/campo_complementario/informacion_pedido_comercial_item' 

			autoload :LocalEntrega, 'pac/factura_electronica/campo_complementario/local_entrega' 

			autoload :Logistica, 'pac/factura_electronica/campo_complementario/logistica' 

			autoload :Medicina, 'pac/factura_electronica/campo_complementario/medicina' 

			autoload :VehiculoNuevo, 'pac/factura_electronica/campo_complementario/vehiculo_nuevo' 
		end		
 
		 def campos


         json = JSON.parse self.to_json

         def agregar_llaves(keys, campo = 0)
          
            if keys.class.to_s == "String" or keys.class.to_s == "NilClass"
               puts "#{"-" * campo} #{keys.class}"
               return keys.class
            else
                 keys.keys.each do |key|
                    clase = keys[key].class.to_s               
                    if key != "xml_hash"
                         if clase == "Hash"   
                              puts "#{"-" * campo} #{key}"                              
                              agregar_llaves(keys[key], campo + 1)
                         else                
                              if clase == "Array"                                                                         
                                   puts "#{"-" * campo} #{key}"
                                   elemento = keys[key].first                                                                                                                                        
                                   agregar_llaves(elemento, campo + 1)
                              else                                                                      
                                   puts "#{"-" * campo} #{key}"
                              end
                         end
                    end
                 end

                return  true
               end
         end

         agregar_llaves(json)
         
     end

	end
end