class Client < ApplicationRecord
	after_create :send_email_to_self
  has_many :orders, dependent: :destroy # un client 1 ---- N  commande
  
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :adresse, presence: true
	validates :tel, presence: true
	validates :sexe, presence: true
	validates :country, presence: true
	validates :zip_code, presence: true

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
	def send_email_to_self
		ClientMailer.welcome_client(self).deliver_now
	end
end
