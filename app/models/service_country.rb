class ServiceCountry < ApplicationRecord
	belongs_to :service
	belongs_to :country
end
