class MassageMassageType < ApplicationRecord
	# relation N - N entre massage et type de massage
	belongs_to :massage
	belongs_to :massage_type
end
