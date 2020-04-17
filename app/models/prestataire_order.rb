class PrestataireOrder < ApplicationRecord
	belongs_to :order_service
  belongs_to :prestataire
end
