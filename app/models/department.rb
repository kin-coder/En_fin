class Department < ApplicationRecord
	belongs_to :country #relation pays-departement
	#une commande est dans un département
	has_many :orders
	#relation Prestataire N-N Depatement
    has_many :prestataire_departments
    has_many :prestataires, through: :prestataire_departments
    
end
