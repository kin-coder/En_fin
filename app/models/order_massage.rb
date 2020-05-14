class OrderMassage < ApplicationRecord
	# relation N - N entre Order et Massage
	belongs_to :order
	belongs_to :massage

	# relation N - N entre order_massage et type de massage
	has_many :order_massage_types
	has_many :massage_types, through: :order_massage_types

	def prestataire
		self.order.order_services.find_by(service_id:Service.find_by_name("Massage").id).prestataire
	end
end
