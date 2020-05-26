class OrderSpa < ApplicationRecord
	# relation N - N entre Order et Sapa
	belongs_to :order
	belongs_to :spa

	# relation 1 - N entre order_spa et spa_ambiance
	belongs_to :spa_ambiance, optional: true

	validates :logement, presence: true
	validates :installation, presence: true
	validates :syteme_eau, presence: true

	def prestataire
		self.order.order_services.find_by(service_id:Service.find_by_name("Location spa").id).prestataire
	end
	
end
