class OrderServiceCategorySubcategory < ApplicationRecord
	#table intermediaire N-N entre subcategory et order_service_category
	belongs_to :subcategory
  	belongs_to :order_service_category
  	# relation devis prestation -(1-N)-order_service_category_subcategory
  	belongs_to :devis_prestation
end
