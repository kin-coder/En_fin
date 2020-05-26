class Order < ApplicationRecord
	#un client 1 - N  commande
	belongs_to :client

	#plusieur commande dans une region
	belongs_to :department, optional: true

	#plusieur commande dans un pays
	belongs_to :country
  
	# relation N - N entre Order et Service
	has_many :order_services, dependent: :destroy
	has_many :services, through: :order_services

	# relation N - N entre Order et Massage
	has_many :order_massages, dependent: :destroy
	has_many :massages, through: :order_massages

	# relation N - N entre Order et Sapa
	has_many :order_spas, dependent: :destroy
	has_many :spas, through: :order_spas


	validates :prestation_date, presence: true
	validates :billing_pays, presence: true
	validates :billing_ville, presence: true
	validates :billing_code_postal, presence: true
	validates :billing_adresse, presence: true

	validates :delivery_pays, presence: true
	validates :delivery_ville, presence: true
	validates :delivery_code_postal, presence: true
	validates :delivery_adresse, presence: true
end
