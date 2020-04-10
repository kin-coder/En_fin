class PrestataireMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.prestataire_mailer.new_candidate.subject
  #
  def new_candidate(candidate)
  	@candidate = candidate
  	@url = 'http://spamandona.herokuapp.com/'
  	# permet d'envoyer l'email à to: ...
  	mail(to: @candidate.email, subject: 'Bienvenue chez Cocooning Spa !')
  end

  def new_orderSpa(order_service)
    @oService = OrderService.find(order_service)
    mail(to: "ctrlfaly@gmail.com", subject: 'Une nouvelle commande pour vous !')
  end

  def new_orderMassage(order_service)
    @oService = OrderService.find(order_service)
    mail(to: "ctrlfaly@gmail.com", subject: 'Une nouvelle commande pour vous !')
  end

end
