class Product < ApplicationRecord
	#pour la sauvegarde des produits N-N produit - order
	has_many :order_products, dependent: :destroy
	has_many :orders, through: :order_products
	#relation Norder spa - 1 product
	has_many :order_spas
end
