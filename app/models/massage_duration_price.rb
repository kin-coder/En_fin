class MassageDurationPrice < ApplicationRecord
	# relation N - N entre massageTypes et massageDurationPrice
	has_many :massage_tmd_prices
	has_many :massage_types, through: :massage_tmd_prices
end
