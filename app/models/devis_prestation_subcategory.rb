class DevisPrestationSubcategory < ApplicationRecord
	# intermediare table subcategory N--N devis_prestation
	belongs_to :subcategory
  	belongs_to :devis_prestation
end
