class MassageSu < ApplicationRecord
	#relation massage_ca-(1-N)-massage_sus
	belongs_to :massage_ca
	#relation massage_su N---N massage_su_price
	has_many :other_su_prices
	has_many :massage_su_prices, through: :other_su_prices
	#relation massage_su 1---N order_massage
	has_many :order_massages
end
