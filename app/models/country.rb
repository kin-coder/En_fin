class Country < ApplicationRecord
	has_many :departments, dependent: :destroy #relation pays(country)-departement
end
