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

	def isExceptional?
		exceptionalDate = [["14","02"],["24","12"],["25","12"],["31","12"]]
		current_date = self.prestation_date.split("/")
		isExeptional = false
		if exceptionalDate.include?(current_date[0..1])
      isExeptional = true
    end
    return isExeptional
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
  	acompteTotal = 0
		priceTotal = 0
    if self.code_promo
      code_promo = self.code_promo.split("-|-")[1].to_f
    end
    if self.is_spa
    	self.order_spas.each do |o_spa|
    		if self.isExceptional?
    			priceTotal += o_spa.spa.exceptional_price
					acompteTotal += o_spa.spa.exceptional_acompte
    		else
    			priceTotal += o_spa.spa.ordinary_price
					acompteTotal += o_spa.spa.ordinary_acompte
    		end
    		unless o_spa.spa_ambiance.nil?
    			priceTotal += o_spa.spa_ambiance.price
    		end
    	end
    end
    if self.is_massage
    	self.order_massages.each do |o_massage|
				o_massage.order_massage_types.each do |o_type|
					if self.isExceptional?
	    			priceTotal += o_type.massage_duration_price.exceptional_price
						acompteTotal += o_type.massage_duration_price.exceptional_acompte
	    		else
	    			priceTotal += o_type.massage_duration_price.ordinary_price
						acompteTotal += o_type.massage_duration_price.ordinary_acompte
	    		end
				end
    	end
    end
		return [priceTotal.to_i-code_promo.to_i,acompteTotal.to_i-code_promo.to_i]
  end
end
