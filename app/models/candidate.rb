class Candidate < ApplicationRecord
	after_create :message_send_to_admin_and_self

	validates :sexe, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :date_of_birth, presence: true
	validates :raison_sociale, presence: true
	validates :siren, presence: true
	validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :telephone, presence: true
	validates :adresse, presence: true
	validates :zip_code, presence: true
	validates :ville, presence: true
	validates :country, presence: true
	validates :services, presence: true
	validates :countries, presence: true
	
	def message_send_to_admin_and_self
		AdminMailer.new_partner(self).deliver_now
		PrestataireMailer.new_candidate(self).deliver_now
	end
end
