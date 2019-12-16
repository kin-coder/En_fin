class Subcategory < ApplicationRecord
	belongs_to :category #relation category-(1-N)-subcategory

    #relation N-N entre commande_category et subcategory
    has_many :order_sub_categories
    has_many :order_categories, through: :order_sub_categories

end
