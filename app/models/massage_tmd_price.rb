class MassageTmdPrice < ApplicationRecord
	# relation N - N entre massageTypes et massageDurationPrice
	belongs_to :massage_type
	belongs_to :massage_duration_price
end
