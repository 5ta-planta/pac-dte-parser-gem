class Pac::Emisor::Emisor
    include Dynamoid::Document
    table name: :emisores, key: :ruc
    field :nombre
    field :tipo
    field :correo
    field :secreto
    field :estado
    field :sucursales, :array  
end