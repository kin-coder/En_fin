class Service < ApplicationRecord
	#relation service-(1-N)-category
	has_many :categories, dependent: :destroy 
	has_many :products, dependent: :destroy
    #une commande N --- 1 service
    #has_many :orders
    #relation Service N-N Prestataire
    has_many :prestataire_services
    has_many :prestataires, through: :prestataire_services
end
