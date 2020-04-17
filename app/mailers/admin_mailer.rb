class AdminMailer < ApplicationMailer
  	#default from: 'no-reply@monsite.fr' #adresse d'email d'envoi
  	
	def contac_us(message)
		@message = message
		@url = 'http://spamandona.herokuapp.com/'
		# permet d'envoyer l'email à to: ...
		mail(to: 'ramahafaly2.0@gmail.com', subject: "Un client a besoin d'information ou d'aide")
	end

	def new_partner(candidate)
		@candidate = candidate
		@url = 'http://spamandona.herokuapp.com/'
		# permet d'envoyer l'email à to: ...
		mail(to: 'ramahafaly2.0@gmail.com', subject: '​Nouvelle demande de partenariat !')
	end

end
