class Emisor
    include Dynamoid::Document
    table name: :emisores, key: :id
    field :id, :integer
    field :nombre
    field :tipo
    field :correo
    field :estado
    field :sucursales, :array  
    field :secret

	field  :created_at, :date
	field  :updated_at, :date

    def initialize
        
    end

end