class OrderProduct < ApplicationRecord
	belongs_to :order
  	belongs_to :product
  	belongs_to :order_spa, optional: true
end
