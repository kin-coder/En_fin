class Commande < ApplicationRecord
    belongs_to :service     #une commande N --- 1 service
    belongs_to :client      #un client 1 ---- N  commande

    #relation N-N entre category et commande
    has_many :commande_categories
    has_many :categories, through: :commande_categories

end
