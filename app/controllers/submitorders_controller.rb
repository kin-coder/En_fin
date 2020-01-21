class SubmitordersController < ApplicationController
  def index_save
    @categoryAndSubCategory = []
    # ---------------- Enregistreer la category_id et les souscategory_id 
    # dans un tableau [4,"5,4"] "  " soucategory
    subcategories = params[:prestations]
    subcategories.each do |k,subcategory|
      listSubcategories = []
      listSubcategories.push(Subcategory.find(subcategory[0]).category)
      subcategory.each do |sub|
        listSubcategories.push(Subcategory.find(sub))
      end
      @categoryAndSubCategory.push(listSubcategories)
    end
    # ---------------- Enregistrer les produits dans un tableau [nb,objet_produit]
    @produitList = []
    produits = params[:products]
    if produits
      produits.uniq.each do |produit_id|
        n = 0
        produits.each do |p|
          if produit_id == p
            n += 1
          end
        end
        @produitList.push([n,Product.find(produit_id.to_i)])
      end
    end
    # ----------------orderInformation [id(depart),adress,date,heure,message]
    @departement = Department.find(params[:department].to_i)
    @pays = @departement.country
    @adresse = params[:Adresse]
    @date = params[:Date]
    @heure = params[:Heure]
    @message = params[:message]

    @priceTotal = totalPrice(@categoryAndSubCategory,@produitList)

    # ---------------------------------------------------------------------- #

    # --------------  INSTRUCTION OU CODE POUR LE PAYEMENT ----------------- #

    # ---------------------------------------------------------------------- #
    
    # Enregistrement des valeur dans la table Commande"
    # table order
    client = Client.first # normalement current_user
    order = Order.create(client: client,service: @categoryAndSubCategory[0][0].service)
    order.date = @date
    order.hours = @heure
    order.adresse = @adresse
    order.message = @message
    order.department = @departement
    order.save
    # table en relation pour la prestations
      # @categoryAndSubCategory # [4,[5,4]]"
    @categoryAndSubCategory.each do |catAsub|
      orderCategory = OrderCategory.create(order: order, category: catAsub[0])
      orderCategory.subcategories = catAsub[1 .. catAsub.length-1]
    end
      # @produitList [nb,objet_produit]"
    @produitList.each do |produit|
      OrderProduct.create(number: produit[0], product: produit[1], order: order)
    end

  	# ClientMailer.with(client: Client.last, commande: order).validation_commande.deliver_now
  end

  def spa_reservation
  	puts "_"*150
  	puts params.inspect
  	puts "_"*150
  end
  private
    def totalPrice(prestations,produits)
      current_price = 0
      prestations.each do |catAsub| # [4,"5,4"] "  " soucategory
        catAsub[1 .. catAsub.length-1].each do |sub|
          current_price += sub.price
        end
      end
      produits.each do |produit| # [nb,objet_produit]
        current_price += produit[0]*produit[1].price
      end
      return current_price
    end
end
