class Spa < ApplicationRecord
	#relation service-(1-N)-spa
	belongs_to :service
	
	# relation N - N entre spa et spa ambiance
	has_many :spa_spa_ambiances
	has_many :spa_ambiances, through: :spa_spa_ambiances

	# relation N - N entre Order et Sapa
	has_many :order_spas, dependent: :destroy
	has_many :orders, through: :order_spas

	validates :duration, presence: true
	validates :exceptional_price, presence: true
	validates :ordinary_price, presence: true
	validates :exceptional_acompte, presence: true
	validates :ordinary_acompte, presence: true
end
