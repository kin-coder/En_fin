class Spa < ApplicationRecord
	#relation service-(1-N)-spa
	belongs_to :service
	
	# relation N - N entre spa et spa ambiance
	has_many :spa_spa_ambiances
	has_many :spa_ambiances, through: :spa_spa_ambiances

	validates :duration, presence: true
	validates :exceptional_price, presence: true
	validates :ordinary_price, presence: true
	validates :exceptional_acompte, presence: true
	validates :ordinary_acompte, presence: true
end
