class CodePromo < ApplicationRecord
	validates :code, presence: true
	# relation codePromo 1-N order
	has_many :orders
end
