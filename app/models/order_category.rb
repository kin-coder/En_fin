class OrderCategory < ApplicationRecord
	#relation N-N entre category et commande // cette class est une table intermediaire
    belongs_to :order
    belongs_to :category
    #relation N-N entre commande_category et subcategory
    has_many :order_sub_categories, dependent: :destroy
    has_many :subcategories, through: :order_sub_categories
end
