class OrderService < ApplicationRecord
	before_create :confirmation_token
	# intermediare table Order N--N Servie
	belongs_to :order
  belongs_to :service
  #relation 1-N entre la commande et le prestataire
  belongs_to :prestataire, optional: true

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
