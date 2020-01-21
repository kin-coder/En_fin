class SubmitordersController < ApplicationController
  def index_save
    # Enregistreer la category_id et les souscategory_id dans un tableau [4,[5,4]]
    subcategories = params[:prestations]
    orderPrestation = []
    subcategories.each do |k,subcategory|
      orderPrestation.push([Subcategory.find(subcategory[0]).category.id,subcategory])
    end
    #Enregistrer les id des produits dans un tableau
    produits = params[:products]
    orderProduit = [] #[nombre,leproduit]
    produits.uniq.each do |produit|
      n = 0
      produits.each do |p|
        if produit == p
          n += 1
        end
      end
      orderProduit.push([n,produit.to_i])
    end
    # orderInformation [id(depart),adress,date,heure,message]
    orderInformation = [params[:department],params[:Adresse],params[:Date],params[:Heure],params[:message]]
    puts "_"*50
    puts "liste des prestations"
    puts orderPrestation.inspect
    puts "_"*50
    puts "liste des produits"
    puts orderProduit.inspect
    puts "_"*50
    puts "Autre information utile"
    puts orderInformation.inspect
    puts "_"*50
  	# ClientMailer.with(client: Client.last, commande: @commande1).validation_commande.deliver_now
  end
  def spa_reservation
  	puts "_"*150
  	puts params.inspect
  	puts "_"*150
  end
end
