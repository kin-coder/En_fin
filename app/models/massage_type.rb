class MassageType < ApplicationRecord
	# relation N - N entre massage et type de massage
	has_many :massage_massage_types
	has_many :massages, through: :massage_massage_types
	# relation N - N entre massageTypes et massageDurationPrice
	has_many :massage_tmd_prices
	has_many :massage_duration_prices, through: :massage_tmd_prices
end
