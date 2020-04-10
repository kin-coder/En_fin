class OrderService < ApplicationRecord
	# intermediare table Order N--N Servie
	belongs_to :order
  belongs_to :service
  #relation 1-N entre la commande et le prestataire
  belongs_to :prestataire, optional: true
end
