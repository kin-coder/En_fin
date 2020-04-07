class PrestataireCountry < ApplicationRecord
  #relation N-N entre country et prestataires
  belongs_to :country
  belongs_to :prestataire
end
