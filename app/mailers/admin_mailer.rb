class AdminMailer < ApplicationMailer
	def contac_us(message)
		@message = message
		@url = 'http://spamandona.herokuapp.com/'
		# permet d'envoyer l'email à to: ...
		mail(to: 'cocooningspa@outlook.com', subject: "Un client a besoin d'information ou d'aide")
	end

	def new_partner(candidate)
		@candidate = candidate
		@url = 'http://spamandona.herokuapp.com/'
		# permet d'envoyer l'email à to: ...
		mail(to: 'cocooningspa@outlook.com', subject: '​Nouvelle demande de partenariat !')
	end

	def new_order_relance_client(order_id,client_id)
		@client = Client.find(client_id)
    @order = Order.find(order_id)
    @date = @order.prestation_date
    @heurs = ["",""]
    @number_service = 0
    @order.order_services.each do |o_s|
      @number_service += 1
    	if o_s.service.name == "Location spa"
    		@heurs[0] = o_s.service_time
    	elsif o_s.service.name == "Massage"
    		@heurs[1] = o_s.service_time
    	end
    end
    @code_promo = 0
    if @order.code_promo
      @code_promo = @order.code_promo.reduction
    end
    mail(to: 'cocooningspa@outlook.com', subject: 'Votre devis effectué en ligne !')
	end

end
