class Prestataire < ApplicationRecord
  #relation Service N-N Prestataire
  has_many :prestataire_services, dependent: :destroy
  has_many :services, through: :prestataire_services
  
  #relation Prestataire N-N Departement
  has_many :prestataire_departments, dependent: :destroy
  has_many :departments, through: :prestataire_departments
  #relation Prestataire N-N Country
  has_many :prestataire_countries, dependent: :destroy
  has_many :countries, through: :prestataire_countries

  #relation 1-N entre la commande et le prestataire
  has_many :order_services
end
