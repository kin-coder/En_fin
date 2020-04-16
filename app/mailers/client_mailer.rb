class ClientMailer < ApplicationMailer
  def confirm_order(order_id,client_id)
    @client = Client.find(client_id)
    @order = Order.find(order_id)
    
    @date = @order.prestation_date.split("/")
    @date = "#{@date[1]}/#{@date[0]}/#{@date[2]}"

    @heurs = ["",""]
    @order.order_services.each do |o_s|
    	if o_s.service.name == "Location spa"
    		@heurs[0] = o_s.service_time
    	elsif o_s.service.name == "Massage"
    		@heurs[1] = o_s.service_time
    	end
    end

    mail(to: @client.email, subject: 'Votre commande Cocooning Spa !')
	end

	def abandoned_order
		
	end
end
