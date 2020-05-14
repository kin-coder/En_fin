class MassageType < ApplicationRecord
	# relation N - N entre massage et type de massage
	has_many :massage_massage_types
	has_many :massages, through: :massage_massage_types

	# relation N - N entre massageTypes et massageDurationPrice
	has_many :massage_tmd_prices
	has_many :massage_duration_prices, through: :massage_tmd_prices

	# relation N - N entre order_massage et type de massage
	has_many :order_massage_types
	has_many :order_massages, through: :order_massage_types
end
