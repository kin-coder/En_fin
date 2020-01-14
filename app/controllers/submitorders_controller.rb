class SubmitordersController < ApplicationController
	before_action :is_valide, only:[:save]
	# Pour la sauvegarde des commande dans la base de donné
	# PAYMENT DE 30% DES SOMME A PAYER DOIT ETRE PAYE
	# AVANT LA SAUVEGARDE EN BASE DE DONNÉ
	# PAYMENT VIA STRIPE OU PAYPAL
  def save
  	order = Order.new
		order.service = Service.find_by(name: session[:service])
		order.client = Client.first
		order.datetime = "34:34 Lundi 30 Nov"
		order.adresse = "Lot 34 TTTT kolo"
		order.description = "bonjour c'est cool ici"
		order.save
		session[:prestation].each do |prestation|
			if prestation["subcategory"] #s'il y a un sous category fait ||
				#le category commander
				orderCategory = OrderCategory.create(order: order, category: Category.find(prestation["category"][1]))
				#les sous-category commander avec!
				prestation["subcategory"].each do |listId|
					orderCategory.subcategories.push(Subcategory.find(listId[0]))
				end
			end
		end
		# Après la sauvegarde vidé la session
		session[:prestation] = []
		session[:service] = ""
		# @commande /variable pour avoirs les donné dans la base de donné
		@commande = order
		@commande1 = []
		@commande1 << order
		# ClientMailer.with(client: Client.last, commande: @commande).validation_commande.deliver_now
		ClientMailer.with(client: Client.last, commande: @commande1).validation_commande.deliver_now
	  end

	  def spa_reservation
	  	@categories = params[:category]
	  	@subcategories = params[:prestations]
	  	puts "_"*150
	  	puts @categories
	  	@subcategories.each do |p|
	  		puts "_"*150
	  		puts p
	  	end
	  	puts "_"*150
	  end
  private
  #Fonction très important
  def is_valide
    if session[:prestation].empty?
			redirect_back(fallback_location: root_path)
		else
			leastone = false
			session[:prestation].each do |prestation|
			  if prestation["subcategory"]
					leastone = true
			  end
			end
			unless leastone
			  redirect_back(fallback_location: root_path)
			end
		end
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
