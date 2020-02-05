class OrderService < ApplicationRecord
	# intermediare table Order N--N Servie
	belongs_to :order
  	belongs_to :service
end
