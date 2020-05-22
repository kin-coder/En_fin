class Product < ApplicationRecord
	#relation Norder spa - 1 product
	validates :name, presence: true
	validates :description, presence: true
	validates :price, presence: true
end
