class Service < ApplicationRecord
	has_many :categories, dependent: :destroy #relation service-(1-N)-category
    has_many :commandes #une commande N --- 1 service
end
