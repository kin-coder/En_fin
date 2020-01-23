class SubmitordersController < ApplicationController
  def index_save
    @categoryAndSubCategory = []
    # ---------------- Enregistreer la category_id et les souscategory_id 
    # dans un tableau [4,"5,4"] "  " soucategory
    subcategories = params[:prestations]
    if subcategories
      subcategories.each do |k,subcategory|
        listSubcategories = []
        listSubcategories.push(Subcategory.find(subcategory[0]).category.id)
        subcategory.each do |sub|
          listSubcategories.push(sub)
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
          @produitList.push([n,produit_id.to_i])
        end
      end
      # Sauvegarder les donné tmp dans la session
      session[:prestations] = [@categoryAndSubCategory,@produitList]
      session[:information] = [params[:department],params[:Adresse],params[:Date],params[:Heure],params[:message]]  
      # ClientMailer.with(client: Client.last, commande: order).validation_commande.deliver_now
      redirect_to recapitulatif_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def spa_reservation
  	puts "_"*150
  	puts params.inspect
  	puts "_"*150
  end

  def index_recapitulatif
    if session[:prestations] == nil || session[:information] == nil
      redirect_to root_path
    else
      # --------------------------- Prestation --------------
      @categoryAndSubCategory = []
      session[:prestations][0].each do |subcategory| #[ca,su,su]
        listSubcategories = []
        listSubcategories.push(Category.find(subcategory[0]))
        subcategory[1..subcategory.length-1].each do |sub|
          listSubcategories.push(Subcategory.find(sub))
        end
        @categoryAndSubCategory.push(listSubcategories)
      end
      # --------------------------- Produit -----------------
      @produitList = []
      session[:prestations][1].each do |produit| #[n,produit_id.to_i]
        @produitList.push([produit[0],Product.find(produit[1])])
      end
      # --------------------------- Information -------------
      information = session[:information]
      @departement = Department.find(information[0])
      @pays = @departement.country
      @adresse = information[1]
      @date = information[2]
      @heure = information[3]
      @message = information[4]
      @priceTotal = totalPrice(@categoryAndSubCategory,@produitList)

    end
    # ---------------------------------------------------------------------- #

    # --------------  INSTRUCTION OU CODE POUR LE PAYEMENT ----------------- #

    # ---------------------------------------------------------------------- #
=begin
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
    session[:prestations] = nil
    session[:information] = nil
=end
    # ClientMailer.with(client: Client.last, commande: order).validation_commande.deliver_now  
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
