class Subcategory < ApplicationRecord
	belongs_to :category #relation category-(1-N)-subcategory

    #relation N-N entre commande_category et subcategory
    has_many :commande_sub_categories
    has_many :commande_categories, through: :commande_sub_categories

end
