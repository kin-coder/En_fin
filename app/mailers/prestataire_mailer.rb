class PrestataireMailer < ApplicationMailer

  def new_candidate(candidate)
  	@candidate = candidate
  	@url = 'http://spamandona.herokuapp.com/'
  	# permet d'envoyer l'email à to: ...
  	mail(to: @candidate.email, subject: 'Bienvenue chez Cocooning Spa !')
  end

  def new_orderSpa(order_service)
    @oService = OrderService.find(order_service)
    @order = @oService.order
    @date = @order.prestation_date.split("/")
    @date = "#{@date[1]}/#{@date[0]}/#{@date[2]}"

    mail(to: "ctrlfaly@gmail.com", subject: 'Une nouvelle commande pour vous !')
  end

  def new_orderMassage(order_service)
    @oService = OrderService.find(order_service)
    @order = @oService.order
    @date = @order.prestation_date.split("/")
    @date = "#{@date[1]}/#{@date[0]}/#{@date[2]}"
    mail(to: "ctrlfaly@gmail.com", subject: 'Une nouvelle commande pour vous !')
  end

end
