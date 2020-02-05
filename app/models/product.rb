class Product < ApplicationRecord
	#pour la sauvegarde des produits N-N produit - order
	has_many :order_products, dependent: :destroy
  	has_many :orders, through: :order_products
end
