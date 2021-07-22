require 'yaml'
require 'rails'
module Pac
	ERRORES_84 = YAML.load_file("config/errores_84.yml")
	AMBIENTE_DESTINO = YAML.load_file("config/ambientes.yml")
	TIPO_EMISION = YAML.load_file("config/tipo_emision.yml")
	TIPO_DOCUMENTO = YAML.load_file("config/tipo_documento.yml")	
    
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
	end
end