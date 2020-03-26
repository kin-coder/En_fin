class AdminMailer < ApplicationMailer
  	default from: 'no-reply@monsite.fr' #adresse d'email d'envoi
	def contac_us(message)
		@message = message
		@url = 'http://spamandona.herokuapp.com/'
		# permet d'envoyer l'email à to: ...
		mail(to:"ctrlfaly@gmail.com", subject: 'Formulaire contactez nous')
	end
end
