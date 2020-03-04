class Country < ApplicationRecord
	has_many :departments, dependent: :destroy #relation pays(country)-departement
	#une commande est dans un département
	has_many :orders
	# relation Service N-N Country
	has_many :service_countries
	has_many :services, through: :service_countries
end
