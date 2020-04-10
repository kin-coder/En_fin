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

  def new_orderSpa
    
  end

  def new_orderMassage
    
  end

end
