class Message < ApplicationRecord
	after_create :message_send

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :tel, presence: true
	validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :content, presence: true

	def message_send
		AdminMailer.contac_us(self).deliver_now
	end
end
