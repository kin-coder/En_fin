class OrderServiceCaSu < ApplicationRecord
	#table intermediaire N-N entre subcategory et order_service_ca
	belongs_to :subcategory
  	belongs_to :order_service_ca
  	# relation devis prestation -(1-N)-order_service_category_su
  	belongs_to :devis_prestation
end
