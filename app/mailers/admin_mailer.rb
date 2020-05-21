class AdminMailer < ApplicationMailer
	def contac_us(message)
		@message = message
		@url = 'http://spamandona.herokuapp.com/'
		# permet d'envoyer l'email à to: ...
		mail(to: 'michael77rakotovao@gmail.com', subject: "Un client a besoin d'information ou d'aide")
	end

	def new_partner(candidate)
		@candidate = candidate
		@url = 'http://spamandona.herokuapp.com/'
		# permet d'envoyer l'email à to: ...
		mail(to: 'michael77rakotovao@gmail.com', subject: '​Nouvelle demande de partenariat !')
	end

end
