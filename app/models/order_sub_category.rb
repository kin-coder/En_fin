class OrderSubCategory < ApplicationRecord
	belongs_to :order_category
    belongs_to :subcategory
end
