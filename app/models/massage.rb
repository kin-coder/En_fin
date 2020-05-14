class Massage < ApplicationRecord
	# relation 1 - N : massage et service
	belongs_to :service

	# relation N - N entre massage et type de massage
	has_many :massage_massage_types
	has_many :massage_types, through: :massage_massage_types

	# relation N - N entre Order et Massage
	has_many :order_massages, dependent: :destroy
	has_many :orders, through: :order_massages
end
