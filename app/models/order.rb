class Order < ApplicationRecord
  #relation Order N---N Service
  has_many :order_services
  has_many :service, through: :order_services

  belongs_to :service     #une commande N --- 1 service
  belongs_to :client      #un client 1 ---- N  commande
  belongs_to :department  #plusieur commande dans une region

  #relation N-N entre la commande et le prestataire pour sauvgarder les prestataire en attente
  has_many :prestataire_orders, dependent: :destroy
  has_many :prestataires, through: :prestataire_orders
  
  #pour la sauvegarde des produits N-N produit - order
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
end
