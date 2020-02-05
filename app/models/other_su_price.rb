class OtherSuPrice < ApplicationRecord
	# intermediare table massage_su N--N massage_su_price
	belongs_to :massage_su
  	belongs_to :massage_su_price
end
