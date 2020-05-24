class PrestataireMailer < ApplicationMailer

  def new_candidate(candidate)
  	@candidate = candidate
  	@url = 'http://spamandona.herokuapp.com/'
  	mail(to: @candidate.email, subject: '​Bienvenue chez Cocooning Spa !')
  end

  def new_orderSpa(order_service,id)
    @prestataire = Prestataire.find(id)
    @oService = OrderService.find(order_service)
    @order = @oService.order
    @date = @order.prestation_date
    mail(to: @prestataire.email, subject: 'Une nouvelle commande Cocooning Spa !')
  end

  def new_orderMassage(order_service,id)
    @prestataire = Prestataire.find(id)
    @oService = OrderService.find(order_service)
    @order = @oService.order
    @date = @order.prestation_date
    mail(to: @prestataire.email, subject: 'Une nouvelle commande Cocooning Spa !')
  end

  def accepted_orderSpa(order_service,id)
    @prestataire = Prestataire.find(id)
    @oService = OrderService.find(order_service)
    @order = @oService.order
    @date = @order.prestation_date.split("/")
    @date = "#{@date[1]}/#{@date[0]}/#{@date[2]}"
    mail(to: @prestataire.email, subject: 'Votre commande Cocooning Spa acceptée !')
  end

  def accepted_orderMassage(order_service,id)
    @prestataire = Prestataire.find(id)
    @oService = OrderService.find(order_service)
    @order = @oService.order
    @date = @order.prestation_date.split("/")
    @date = "#{@date[1]}/#{@date[0]}/#{@date[2]}"
    mail(to: @prestataire.email, subject: 'Votre commande Cocooning Spa acceptée !')
  end

  def oups_order_not_available(id)
    @prestataire = Prestataire.find(id)
    mail(to: @prestataire.email, subject: "​Commande déjà prise !")
  end

  def delete_prestataire_for_order(id,order_id)
    @prestataire = Prestataire.find(id)
    @order_id = order_id
    mail(to: @prestataire.email, subject: "Prise en charge annulée!")
  end
end
