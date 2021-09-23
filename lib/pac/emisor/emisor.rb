class Pac::Emisor::Emisor
    include Dynamoid::Document
    table name: :emisores, key: :id
    range :nombre
    field :nombre
    field :tipo
    field :correo
    field :estado
    #field :sucursales, :array  
    field :secret
end