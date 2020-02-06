class OrderMassage < ApplicationRecord
	# relation order 1-N order_massage
	belongs_to :order
	#relation massage_ca 1---N order_massage
	belongs_to :massage_ca
	#relation massage_su 1---N order_massage
	belongs_to :massage_su
	#relation massage_su_price 1---N order_massage
	belongs_to :massage_su_price
end
