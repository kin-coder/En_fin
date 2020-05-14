class OrderSpa < ApplicationRecord
	# relation N - N entre Order et Sapa
	belongs_to :order
	belongs_to :spa

	validates :logement, presence: true
	validates :installation, presence: true
	validates :syteme_eau, presence: true

	def prestataire
		self.order.order_services.find_by(service_id:Service.find_by_name("Location spa").id).prestataire
	end
	
end
