class Department < ApplicationRecord
	belongs_to :country #relation pays-departement
	#une commande est dans un département
	has_many :orders
	#relation Prestataire N-N Depatement
  has_many :prestataire_departments
  has_many :prestataires, through: :prestataire_departments
  # relation Service N-N Department
  has_many :service_departments
	has_many :services, through: :service_departments

	validates :name, presence: true
	validates :code, presence: true
end
