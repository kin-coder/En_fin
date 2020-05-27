class CodePromo < ApplicationRecord
	validates :code, presence: true
	# relation codePromo 1-N order
end
