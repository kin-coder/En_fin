class SubmitordersController < ApplicationController
	# Pour la sauvegarde des commande dans la base de donné
	# PAYMENT DE 30% DES SOMME A PAYER DOIT ETRE PAYE
	# AVANT LA SAUVEGARDE EN BASE DE DONNÉ
	# PAYMENT VIA STRIPE OU PAYPAL
  def index_save # reservation pour le massage la location spa
  	puts "_"*150
  	puts params.inspect
  	puts "_"*150
	# ClientMailer.with(client: Client.last, commande: @commande1).validation_commande.deliver_now
  end
  def spa_reservation
  	puts "_"*150
  	puts params.inspect
  	puts "_"*150
  end
end
