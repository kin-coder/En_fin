class Category < ApplicationRecord
	belongs_to :service #relation service-(1-N)-category
    has_many :subcategories, dependent: :destroy #relation category-(1-N)-subcategory
    
    #relation N-N entre category et order_service
    has_many :order_service_categories
  	has_many :order_service, through: :order_service_categories
end
