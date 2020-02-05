class MassageCa < ApplicationRecord
	belongs_to :service #relation service-(1-N)-massages
	#relation massage_ca-(1-N)-massage_sus
	has_many :massage_sus, dependent: :destroy
end
