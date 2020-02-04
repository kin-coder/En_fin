class OrderServiceCa < ApplicationRecord
	#table intermediaire N-N entre category et order_service
	belongs_to :category
  	belongs_to :order_service

    #relation N-N entre subcategory et order_service_ca
    has_many :order_service_ca_sus
  	has_many :subcategory, through: :order_service_ca_sus

  	#relation 1-1 order_service_ca et order_service_ca_spa
  	has_one :order_service_ca_spa
end
