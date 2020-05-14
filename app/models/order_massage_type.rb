class OrderMassageType < ApplicationRecord
	# relation N - N entre order_massage et type de massage
	belongs_to :order_massage
	belongs_to :massage_type
	# relation 1 - N entre order_massage_type et massage_duration_price
	belongs_to :massage_duration_price
end
