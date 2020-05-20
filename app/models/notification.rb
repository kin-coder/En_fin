class Notification < ApplicationRecord
	def order_id
		if self.notif_type == 1
				return JSON.parse(self.data)["id"]
		end
	end
	def messages
		return JSON.parse(self.data)["text"]
	end
end
