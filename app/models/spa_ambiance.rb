class SpaAmbiance < ApplicationRecord
	# relation N - N entre spa et spa ambiance
	has_many :spa_spa_ambiances
	has_many :spas, through: :spa_spa_ambiances
	# relation 1 - N entre order_spa et spa_ambiance
	has_many :order_spas, dependent: :destroy
end
