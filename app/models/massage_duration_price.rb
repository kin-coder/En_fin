class MassageDurationPrice < ApplicationRecord
	# relation N - N entre massageTypes et massageDurationPrice
	has_many :massage_tmd_prices
	has_many :massage_types, through: :massage_tmd_prices

	# relation 1 - N entre order_massage_type et massage_duration_price
	has_many :order_massage_types, dependent: :destroy

	def massageTypes(category)
		massage = Massage.find_by_name(category)
		self.massage_types.joins(:massage_massage_types).where(massage_massage_types:{massage_id:massage.id})
	end

end
