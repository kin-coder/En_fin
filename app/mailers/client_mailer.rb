class ClientMailer < ApplicationMailer
    def validation_commande

        @client = params[:client]
        @commande = params[:commande]

        @url  = 'http://example.com/login'
        mail(to: "michael77rakotovao@gmail.com", subject: 'Confirmation commandes')
      end
end
