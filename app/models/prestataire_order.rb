class PrestataireOrder < ApplicationRecord
	belongs_to :order
  belongs_to :prestataire
end
