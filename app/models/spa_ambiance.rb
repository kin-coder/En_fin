class SpaAmbiance < ApplicationRecord
	# relation N - N entre spa et spa ambiance
	has_many :spa_spa_ambiances
	has_many :spas, through: :spa_spa_ambiances
end
