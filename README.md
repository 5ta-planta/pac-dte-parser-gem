# pac-dte-parser-gem

campos del objeto

version_del_formato
 identificador_para_firma_electronica
 ambiente_destino
 tipo_de_emision
 fecha_hora_inicio_contingencia
 razon_operacion_contingencia
 tipo_documento
 numero_documento_fiscal
 punto_facturacion_documento_fiscal
 codigo_de_seguridad
 fecha_emision_documento
 fecha_salida_estimada_mercancias
 naturaleza_operacion
 tipo_operacion
 destino_operacion
 formato_generacion_cafe
 manera_entrega_cafe
 envio_contenedor_cafe
 proceso_generacion_fe
 tipo_transaccion_venta
 tipo_sucursal
 informacion_interes_emisor_fe
 emisor
- tipo_de_contribuyente
- ruc
- dv_ruc
- nombre
- sucursal
- coordenadas
- direccion
- existe_gUbiEm
- codigo_ubicacion
- corregimiento
- distrito
- provincia
- telefono_contacto
- correo
 receptor
- tipo_receptor
- tipo_de_contribuyente
- ruc
- dv_ruc
- nombre
- direccion
- existe_gUbiRec
- existe_gRucRec
- codigo_ubicacion
- corregimiento
- distrito
- provincia
- existe_gIdExt
- identificacion_extranjero
- pais_extranjero
- telefono
-- String
- correo
- pais
- pais_descripcion
 exportacion
- existe_gFExp
- incoterm
- moneda
- moneda_descripcion
- tipo_cambio
- monto_moneda_extranjera
- puerto_embarque
 lista_doc_fiscal_referenciado
- existe_gDFRef
- tipo_contribuyente
- ruc_contribuyente
- dv_ruc_contribuyente
- nombre_emisor
- fecha_emision
- cufe_fe_referenciada
- cufe
-- cufe_a_validar
-- cufe
-- tipo_documento
-- tipo_contribuyente
-- ruc_del_emisor
-- dv_rc
-- codigo_sucursal
-- fecha_emision
-- numero_factura
-- punto_facturacion
-- tipo_de_emision
-- ambiente_destino
-- secuencia_seguridad
-- dv_cufe
 lista_items
- numero_item
- descripcion_producto_servicio
- codigo_interno
- unidad_medida
- cantidad_producto_servicio
- fecha_fabricacion
- fecha_caducidad
- codigo_item_codificacion_panama_abbreviada
- codigo_item_codificacion_panama
- unidad_medida_codificacion_panama
- informacion
- precio_unitario
- descuento
- precio
- precio_acarreo
- precio_seguro
- total
- codigo_gtin_unidad_comercializadora
- cantidad_gtin_unidad_comercializadora
- codigo_gtin_unidad_inventario
- cantidad_gtin_unidad_inventario
- tasa_itbms
- monto_itbms
- tasa_isc
- monto_isc
- complemento_vehiculo_nuevo
-- mod_operacion_vta_veh_nuevo
-- mod_operacion_vta_veh_nuevo_no_listado
-- chasis
-- color
-- desc_color
-- potencia
-- capacidad_motor
-- peso_neto
-- peso_bruto
-- tipo_combustible
-- tipo_combustible_no_listado
-- numero_motor
-- cap_max_traccion
-- distancia_ejes
-- aaaa_mod_fabricacion
-- aaaa_fabricacion
-- tipo_pintura
-- tipo_pintura_no_listada
-- tipo
-- uso
-- condicion
-- cap_max_pasajeros
- complemento_medicina
-- numero_lote
-- cantidad_productos
- complemento_pedido_comercial_relacionado_item
-- numero_pedido
-- numero_item
-- informacion
 sub_totales
- total_neto
- total_itbms
- total_isc
- total_gravado
- total_descuentos
- total_acarreo
- total_seguro
- total_factura
- suma_valores_recibidos
- vuelto
- tiempo_pago
- numero_total_items
- total_items
 lista_descuentos_bonificaciones_adicionales
- descripcion_descuentos_adicionales
- monto_descuentos_adicionales
 lista_formas_pago
- forma_pago
- descripcion_forma_pago_no_listada
- valor_forma_pago
 retenciones
- codigo_retencion
- monto_retencion
 lista_informacion_pago_plazo
- numero_cuota
- fecha_vencimiento_cuota
- valor_cuota
- informacion
 lista_total_otras_tasas
- codigo_otras_tasas
- total
 pedido_comercial
- numero_pedido
- numero_aceptacion
- codigo_receptor
- codigo_sistema_emisor
- informacion
 informacion_logistica
- numero_volumenes
- peso_total_carga
- unidad_peso_total_carga
- licencia_vehiculo_carga
- nombre_transportista
- tipo_contribuyente_transportista
- ruc_transportista
- dv_ruc_transportista
- informacion
 identificacion_local_de_entrega
- tipo_contribuyente
- ruc
- dv_ruc
- razon_social
- direccion_local
- codigo_ubicacion
- corregimiento
- distrito
- provincia
- telefono
- telefono_adicional
 firma_electronica
- Id
- SignedInfo
-- Id
-- CanonicalizationMethod
--- Algorithm
-- SignatureMethod
--- Algorithm
--- HMACOutputLength
-- Reference
--- Id
--- URI
--- Type
--- Transforms
---- Transform
----- Algorithm
----- auto_generated_for_wildcard
------ NilClass
--- DigestMethod
---- Algorithm
---- auto_generated_for_wildcard
----- NilClass
--- DigestValue
- SignatureValue
- KeyInfo
-- Id
-- KeyName
--- String
- Object
-- Id
-- MimeType
-- Encoding
-- auto_generated_for_wildcard
--- NilClass
 codigo_qr
 cufe
- cufe_a_validar
- cufe
- tipo_documento
- tipo_contribuyente
- ruc_del_emisor
- dv_rc
- codigo_sucursal
- fecha_emision
- numero_factura
- punto_facturacion
- tipo_de_emision
- ambiente_destino
- secuencia_seguridad
- dv_cufe
