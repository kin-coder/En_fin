class CommandeCategory < ApplicationRecord
	#relation N-N entre category et commande // cette class est une table intermediaire
    belongs_to :commande
    belongs_to :category
    #relation N-N entre commande_category et subcategory
    has_many :commande_sub_categories
    has_many :subcategories, through: :commande_sub_categories

end
