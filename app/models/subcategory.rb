class Subcategory < ApplicationRecord
	belongs_to :category #relation category-(1-N)-subcategory
	
    #relation N-N entre subcategory et order_service_ca
    has_many :order_service_ca_sus
  	has_many :order_service_category, through: :order_service_ca_sus
  	#relation N-N entre subcategory et devis_prestation
    has_many :devis_prestation_subcategories
  	has_many :devis_prestation, through: :devis_prestation_subcategories
end
