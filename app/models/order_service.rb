class OrderService < ApplicationRecord
	# intermediare table Order N--N Servie
	belongs_to :order
  	belongs_to :service
  	#relation N-N entre category et order_service
    has_many :order_service_categories
  	has_many :category, through: :order_service_categories
end
