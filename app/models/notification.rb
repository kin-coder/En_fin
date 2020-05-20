class Notification < ApplicationRecord
	def order_id
		if self.notif_type == 1
				return JSON.parse(self.data)["id"]
		end
	end
	def messages
		return JSON.parse(self.data)["text"]
	end
	def self.notSee
		Notification.where(is_view:false).count
	end
	def self.lastIndex
		if Notification.last
			return Notification.last.id
		else
			return 0
		end
	end
end
