class SubmitordersController < ApplicationController
	# Pour la sauvegarde des commande dans la base de donné
	# PAYMENT DE 30% DES SOMME A PAYER DOIT ETRE PAYE
	# AVANT LA SAUVEGARDE EN BASE DE DONNÉ
	# PAYMENT VIA STRIPE OU PAYPAL
  def save # reservation pour le massage la location spa
  	puts "_"*150
  	puts "_"*150
  	puts params.inspect
  	puts "_"*150
  	puts "_"*150
	# ClientMailer.with(client: Client.last, commande: @commande1).validation_commande.deliver_now
  end

  def spa_reservation
  	puts "_"*150
  	puts params.inspect
  	puts "_"*150

  end
  
end

=begin
	#order.destroy #suppresion de tous les donné déja sauvegardé
	order.categories # array des differents category [possibilité de .name]
	order.service
	order.client
	mandona = order.order_categories
	mandona[O].category 							# Voir le category conserné
	mandona[0].subcategories					# Voir seulment les sous-category acheté
	order.service.prestataires # Voir la listes des prestataires qui peut faire le service
	Envoi d'email a tous les prestataire avec un lien qui demande s'il peut faire la commande
=end
