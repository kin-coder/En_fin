class Order < ApplicationRecord
    belongs_to :service     #une commande N --- 1 service
    belongs_to :client      #un client 1 ---- N  commande

    #relation N-N entre category et commande
    has_many :order_categories, dependent: :destroy
    has_many :categories, through: :order_categories

    #relation N-N entre la commande et le prestataire pour sauvgarder les prestataire en attente
    has_many :prestataire_orders, dependent: :destroy
    has_many :prestataires, through: :prestataire_orders
end
