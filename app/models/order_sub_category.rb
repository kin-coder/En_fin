class OrderSubCategory < ApplicationRecord
	belongs_to :order_category
    belongs_to :subcategory
    has_one :order_spa_info_subcategory
end
