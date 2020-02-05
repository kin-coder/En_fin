class Service < ApplicationRecord
	# relation service-(1-N)-massage
	has_many :massages, dependent: :destroy
	# relation service-(1-N)-spa
	has_many :spas, dependent: :destroy
	# relation Order N---N Service
	has_many :order_services
	has_many :order, through: :order_services
	# relation Service N-N Prestataire
	has_many :prestataire_services
	has_many :prestataires, through: :prestataire_services
end
