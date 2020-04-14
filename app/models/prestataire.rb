class Prestataire < ApplicationRecord
  before_create :confirmation_token
  #relation Service N-N Prestataire
  has_many :prestataire_services, dependent: :destroy
  has_many :services, through: :prestataire_services
  
  #relation Prestataire N-N Departement
  has_many :prestataire_departments, dependent: :destroy
  has_many :departments, through: :prestataire_departments

  #relation Prestataire N-N Country
  has_many :prestataire_countries, dependent: :destroy
  has_many :countries, through: :prestataire_countries

  # relation 1-N entre la commande et le prestataire
  # Enregistrement des prestataire qui va faire la prestation
  has_many :order_services

  # relation N-N entre la commande et le prestataire pour sauvgrder les prestataire en attente
  has_many :prestataire_orders
  has_many :order_services, through: :prestataire_orders

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
# user = User.find_by_confirm_token(params[:id])
# <%= confirm_email_user_url(@user.confirm_token) %>
end
