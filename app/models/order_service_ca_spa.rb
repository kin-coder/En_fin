class OrderServiceCaSpa < ApplicationRecord
	#relation 1-1 order_service_ca et order_service_ca_spa
  belongs_to :order_service_ca
end
