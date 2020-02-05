class PrestataireOrder < ApplicationRecord
  #relation N-N entre la commande et le prestataire pour sauvgrder les prestataire en attente
  belongs_to :order
  belongs_to :prestataire
end
