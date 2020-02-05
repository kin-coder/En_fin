class MassageSuPrice < ApplicationRecord
	#relation massage_su N---N massage_su_price
	has_many :other_su_prices
	has_many :massage_su, through: :other_su_prices
end
