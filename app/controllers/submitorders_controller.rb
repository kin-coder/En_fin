class SubmitordersController < ApplicationController
  def save
  	order = Order.new
		order.service = Service.find_by(name: session[:service])
		order.client = Client.first
		order.datetime = "34:34 Lundi 30 Nov"
		order.adresse = "Lot 34 TTTT kolo"
		order.description = "bonjour c'est cool ici"
		order.save

		session[:prestation].each do |prestation| 
			#le category commander
			orderCategory = OrderCategory.create(order: order, category: Category.find(prestation["category"][1]))
			#les sous-category commander avec!
			prestation["subcategory"].each do |listId|
				orderCategory.subcategories.push(Subcategory.find(listId[0]))
			end
		end
  end
  
end

=begin

	order.categories # array des differents category [possibilité de .name]
	order.service
	order.client
	mandona = order.order_categories
	mandona[O].category 							# Voir le category conserné
	mandona[0].subcategories					# Voir seulment les sous-category acheté
	
	order.service.prestataires # Voir la listes des prestataires qui peut faire le service
	Envoi d'email a tous les prestataire avec un lien qui demande s'il peut faire la commande
	
=end