class ClientMailer < ApplicationMailer
  def confirm_order(order_id,client_id)
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
    mail(to: @client.email, subject: 'Votre commande Cocooning Spa !')
  end

  def abandoned_order
  end

  def welcome_client(client)
    @client = client
    mail(to: @client.email, subject: 'Votre compte client a bien été créé !')
  end
end

#unless admin_id.nil?
#mail(to: "cocooningspa@outlook.com", subject: 'Votre commande Cocooning Spa !')
#else