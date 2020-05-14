class Massage < ApplicationRecord
	# relation N - N entre massage et type de massage
	has_many :massage_massage_types
	has_many :massage_types, through: :massage_massage_types
	# relation 1 - N : massage et service
	belongs_to :service
end
