class Pac::Emisor::Emisor
    include Dynamoid::Document
    table name: :emisores, key: :ruc
    field :tipo_contribuyente
    field :nombre
    field :digito_verificador
    field :ruc_afiliado_sfe, :boolean
    field :resolucion_autorizacion
    field :secreto
    field :estado
    field :sucursales, :array  
end