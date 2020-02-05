class OrderServiceCategory < ApplicationRecord
	#table intermediaire N-N entre category et order_service
	belongs_to :category
  	belongs_to :order_service

    #relation N-N entre subcategory et order_service_category
    has_many :order_service_category_subcategories
  	has_many :subcategory, through: :order_service_category_subcategories

  	#relation 1-1 order_service_category et order_service_category_spa
  	has_one :order_service_category_spa
end
