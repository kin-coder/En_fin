class DevisPrestation < ApplicationRecord
	#relation N-N entre subcategory et devis_prestation
    has_many :devis_prestation_subcategories
  	has_many :subcategory, through: :devis_prestation_subcategories
  	# relation devis_prestation -(1-N)-order_service_category_subcategory
	has_many :order_service_ca_sus
end
