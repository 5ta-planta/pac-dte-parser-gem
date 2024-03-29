require 'rails'
require 'dynamoid'

module Pac	     
	module Recepcion
		autoload :Fe, 	'pac/recepcion/fe'
		autoload :Lote, 'pac/recepcion/lote'
		autoload :Ev, 'pac/recepcion/ev'
	end

	module Emisor
		autoload :Emisor, 'pac/emisor/emisor'
	end

	module Constante
		autoload :Constante, 'pac/constante/constante'
	end
	
	module FacturaElectronica		  
		autoload :FacturaElectronica, 'pac/factura_electronica/factura_electronica'
		autoload :FirmaElectronica, 'pac/factura_electronica/firma_electronica'
		autoload :Emisor, 'pac/factura_electronica/emisor'
		autoload :Cufe, 'pac/factura_electronica/cufe'
		autoload :Header, 'pac/factura_electronica/header'
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
	end
	module Evento
		autoload :Anulacion, 'pac/evento/anulacion'
		autoload :Manifestacion, 'pac/evento/manifestacion'
		autoload :Emisor , 'pac/evento/emisor'
	end

	module ProtocoloAutorizacion
		autoload :AutorizacionPac, 'pac/protocolo_autorizacion/autorizacion_pac'
	end
end