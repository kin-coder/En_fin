class Product < ApplicationRecord
	#relation Norder spa - 1 product
	has_many :order_spas

	validates :name, presence: true
	validates :description, presence: true
	validates :price, presence: true
end
