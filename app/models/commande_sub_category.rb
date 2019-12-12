class CommandeSubCategory < ApplicationRecord
	belongs_to :commande_category
    belongs_to :subcategory
end
