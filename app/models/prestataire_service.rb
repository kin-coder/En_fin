class PrestataireService < ApplicationRecord
  #relation Service N-N Prestataire
  belongs_to :prestataire
  belongs_to :service
end
