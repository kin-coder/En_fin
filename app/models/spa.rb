class Spa < ApplicationRecord
	belongs_to :service #relation service-(1-N)-spa
end
