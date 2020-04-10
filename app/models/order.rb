class Order < ApplicationRecord
	belongs_to :client      #un client 1 ---- N  commande
	belongs_to :department, optional: true  #plusieur commande dans une region
	belongs_to :country #plusieur commande dans un pays
	#relation Order N---N Service
	has_many :order_services
	has_many :services, through: :order_services
	
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

	def isExceptional?
		exceptionalDate = [["02","14"],["12","24"],["12","25"],["12","31"]]
		current_date = self.prestation_date.split("/")
		isExeptional = false
		if exceptionalDate.include?(current_date[0..1])
      isExeptional = true
    end
    return isExeptional
	end

end