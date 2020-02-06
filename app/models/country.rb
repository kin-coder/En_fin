class Country < ApplicationRecord
	has_many :departments, dependent: :destroy #relation pays(country)-departement
	#une commande est dans un département
	has_many :orders
end
