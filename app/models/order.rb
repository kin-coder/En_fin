class Order < ApplicationRecord
	belongs_to :client      #un client 1 ---- N  commande
	belongs_to :department, optional: true  #plusieur commande dans une region
	belongs_to :country #plusieur commande dans un pays
	#relation Order N---N Service
	has_many :order_services
	has_many :services, through: :order_services
	
	#relation N-N entre la commande et le prestataire pour sauvgarder les prestataire en attente
	has_many :prestataire_orders, dependent: :destroy
	has_many :prestataires, through: :prestataire_orders
	
	#pour la sauvegarde des produits N-N produit - order
	has_many :order_products, dependent: :destroy
	has_many :products, through: :order_products
	
	# relation order 1-N order_massage
	has_many :order_massages, dependent: :destroy
	
	# relation order 1-N order_spa
	has_many :order_spas, dependent: :destroy

	validates :prestation_date, presence: true
	validates :billing_pays, presence: true
	validates :billing_ville, presence: true
	validates :billing_code_postal, presence: true
	validates :billing_adresse, presence: true
	validates :billing_adresse_complet, presence: true
	validates :delivery_pays, presence: true
	validates :delivery_ville, presence: true
	validates :delivery_code_postal, presence: true
	validates :delivery_adresse, presence: true
	validates :delivery_adresse_complet, presence: true

end
