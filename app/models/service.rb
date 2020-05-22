class Service < ApplicationRecord
	# relation service-(1-N)-massage
	has_many :massages, dependent: :destroy
	
	# relation service-(1-N)-spa
	has_many :spas, dependent: :destroy

	# relation N - N entre Order et Service
	has_many :order_services, dependent: :destroy
	has_many :order, through: :order_services

	# relation N - N Service et Prestataire
	has_many :prestataire_services
	has_many :prestataires, through: :prestataire_services

	# relation N - N Service et Country
	has_many :service_countries
	has_many :countries, through: :service_countries

	# relation N - N Service et Department
	has_many :service_departments
	has_many :departments, through: :service_departments

	validates :name, presence: true
end
