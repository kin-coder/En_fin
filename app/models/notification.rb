class Notification < ApplicationRecord
	def url
		if self.notif_type == 1
				return "/admin/commande-numero/#{(JSON.parse(self.data)["id"])}"
		end
	end
	def messages
		return JSON.parse(self.data)["text"]
	end
end
