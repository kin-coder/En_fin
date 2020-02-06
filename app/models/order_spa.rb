class OrderSpa < ApplicationRecord
	# relation order 1-N order_spa
	belongs_to :order
	# relation spa -(1-N)- order_massage
	belongs_to :spa
	# relation spa -(1-N)- order_massage
	has_many :order_products
end
