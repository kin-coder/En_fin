class Candidate < ApplicationRecord
	validates :sexe, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :date_of_birth, presence: true
	validates :raison_sociale, presence: true
	validates :siret, presence: true
	validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :telephone, presence: true
	validates :adresse, presence: true
	validates :zip_code, presence: true
	validates :ville, presence: true
	validates :country, presence: true
	validates :services, presence: true
end
