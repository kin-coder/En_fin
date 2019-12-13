class PrestataireDepartment < ApplicationRecord
  #relation N-N entre departements et prestataires
  belongs_to :department
  belongs_to :prestataire
end
