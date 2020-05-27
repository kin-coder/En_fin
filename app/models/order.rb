class Order < ApplicationRecord
	belongs_to :client      #un client 1 ---- N  commande
	belongs_to :department, optional: true  #plusieur commande dans une region
	belongs_to :country #plusieur commande dans un pays
	# relation codePromo 1-N order
	belongs_to :code_promo, optional: true
	#relation Order N---N Service
	has_many :order_services, dependent: :destroy
	has_many :services, through: :order_services
	# relation order 1-N order_massage
	has_many :order_massages, dependent: :destroy
	# relation order 1-N order_spa
	has_many :order_spas, dependent: :destroy

	validates :prestation_date, presence: true
	validates :billing_pays, presence: true
	validates :billing_ville, presence: true
	validates :billing_code_postal, presence: true
	validates :billing_adresse, presence: true

	validates :delivery_pays, presence: true
	validates :delivery_ville, presence: true
	validates :delivery_code_postal, presence: true
	validates :delivery_adresse, presence: true


	def isExceptional?
		exceptionalDate = [["14","02"],["24","12"],["25","12"],["31","12"]]
		current_date = self.prestation_date.split("/")
		isExeptional = false
		if exceptionalDate.include?(current_date[0..1])
      isExeptional = true
    end
    return isExeptional
	end

  def is_future?
  	current_date = self.prestation_date.split("/")
		is_future_date = false
  	self.order_services.each do |o_s|
  		current_time = o_s.service_time.split(":")
  		current_DateTime = Time.new(current_date[2],current_date[0],current_date[1],current_time[0],current_time[1])
  		if current_DateTime.future?
  			is_future_date = true
  		end
  	end
  	return is_future_date
  end

  def prestataires
  	list_prestataires = []
  	self.order_services.each do |o_s|
  		unless o_s.prestataire.nil?
  			case o_s.service.name
  				when "Location spa"
  					list_prestataires.push(['spa',o_s.prestataire])
  				when "Massage"
  					list_prestataires.push(['massage',o_s.prestataire])
  				else
  			end
  		end
  	end
  	return list_prestataires
  end

  def totalPrice
  	code_promo = 0
    if self.code_promo
      code_promo = self.code_promo.reduction
    end

  	acompte = 0
  	price = 0
		self.order_services.each do |o_s|
			if o_s.service.name == "Massage"
				self.order_massages.each do |o_massage| 
					if self.isExceptional?
						price += o_massage.massage_su_price.exceptional_price
						acompte += o_massage.massage_su_price.exceptional_acompte
					else
						price += o_massage.massage_su_price.ordinary_price
						acompte += o_massage.massage_su_price.ordinary_acompte
					end
				end
			elsif o_s.service.name == "Location spa"
				self.order_spas.each do |o_spa|
					if self.isExceptional?
						price += o_spa.spa.exceptional_price
						acompte += o_spa.spa.exceptional_acompte 
					else
						price += o_spa.spa.ordinary_price
						acompte += o_spa.spa.ordinary_acompte
					end
					unless o_spa.product.nil?
						price += o_spa.product.price
					end
				end 
			end
		end
		return [price.to_i-code_promo.to_i,acompte.to_i-code_promo.to_i]
  end
end
