class OrderSpa < ApplicationRecord
	# relation order 1-N order_spa
	belongs_to :order
	# relation orderSpa -(1-N)- spa
	belongs_to :spa
	# relation spa -(1-N)- produit
	belongs_to :product, optional: true

	validates :logement, presence: true
	validates :installation, presence: true
	validates :syteme_eau, presence: true
	def prestataire
		self.order.order_services.find_by(service_id:Service.find_by_name("Location spa").id).prestataire
	end
end
