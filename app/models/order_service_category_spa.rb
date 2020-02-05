class OrderServiceCategorySpa < ApplicationRecord
	#relation 1-1 order_service_category et order_service_category_spa
  belongs_to :order_service_category
end
