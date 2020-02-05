class Prestataire < ApplicationRecord
  #relation Service N-N Prestataire
  has_many :prestataire_services, dependent: :destroy
  has_many :services, through: :prestataire_services
  
  #relation Prestataire N-N Departement
  has_many :prestataire_departments, dependent: :destroy
  has_many :departments, through: :prestataire_departments

  #relation N-N entre la commande et le prestataire pour sauvgrder les prestataire en attente
  #has_many :prestataire_orders
  #has_many :orders, through: :prestataire_orders
end
