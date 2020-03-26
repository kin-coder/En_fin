class Message < ApplicationRecord
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :tel, presence: true
	validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :content, presence: true
end
