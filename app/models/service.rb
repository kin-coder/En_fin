class Service < ApplicationRecord
	# relation service-(1-N)-category
	has_many :categories, dependent: :destroy
	# relation Order N---N Service
	has_many :order_services
	has_many :order, through: :order_services
	# relation Service N-N Prestataire
	has_many :prestataire_services
	has_many :prestataires, through: :prestataire_services
end
