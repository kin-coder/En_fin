class MassageSuPrice < ApplicationRecord
	#relation massage_su N---N massage_su_price
	has_many :other_su_prices, dependent: :destroy
	has_many :massage_sus, through: :other_su_prices
	#relation massage_su_price 1---N order_massage
	has_many :order_massages
end
