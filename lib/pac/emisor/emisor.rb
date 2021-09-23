class Pac::Emisor::Emisor
    include Dynamoid::Document
    table name: :emisores, key: :id
     
    field :nombre
    field :tipo
    field :correo
    field :estado
    #field :sucursales, :array  
    field :secret

	 

    def initialize
        
    end

end