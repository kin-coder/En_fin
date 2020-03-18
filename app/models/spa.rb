class Spa < ApplicationRecord
	#relation service-(1-N)-spa
	belongs_to :service
	# relation spa -(1-N)- order_massage
	has_many :order_massages

	validates :duration, presence: true
	validates :exceptional_price, presence: true
	validates :ordinary_price, presence: true
	validates :exceptional_acompte, presence: true
	validates :ordinary_acompte, presence: true

end
