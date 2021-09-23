class Pac::Emisor::Emisor<Dynamoid::Document
    include Dynamoid::Document
    table name: :emisores, key: :id
    range :nombre
    field :nombre
    field :tipo
    field :correo
    field :estado
    #field :sucursales, :array  
    field :secret

	 

    

     

    def ultimo_registro
        Pac::Emisor::Emisor.last
    end




end