class SubmitordersController < ApplicationController
# ------------------------- SAVE AT SESSION SUBMIT ----------------------- #
before_action :index_validate_session, only: [:index_recapitulatif, :index_pay_reservation]
before_action :spa_validate_session, only: [:spa_recapitulatif, :spa_pay_reservation]

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
      redirect_to recapitulatif_index_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

# --------------------- VIEW RECAPITULATIF COMMANDE ----------------------- #

def index_recapitulatif

end

# ------------------------- SAVE IN TABLE IF PAYED ----------------------- #

def index_pay_reservation
    # Amount in cents
    @amount = (@priceTotal*100 + 2000).to_i

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Pament pour lutilisateur no 1',
      currency: 'eur',
    })

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
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to recapitulatif_index_path
    end

# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #

# ------------------------- SAVE AT SESSION SUBMIT ----------------------- #
def spa_reservation
  subcategory = params[:subcategory]
  if subcategory
      # ~~~~~~~~~~~~~~~~ PRESTATION SPA ~~~~~~~~~~~~~~~~~~~~~
      @prestations = []
      n = 0
      params[:prestations].each do |id,info|
        @prestations.push([subcategory[n],info])
        n += 1
      end
      # ~~~~~~~~~~~~~~~~~~~ PRODUITS ~~~~~~~~~~~~~~~~~~~~~~~~
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
      # ~~~~~~~~~~~ Sauvegarder les donné tmp dans la session
      session[:prestations] = [@prestations,@produitList]
      session[:information] = [params[:department],params[:Adresse],params[:Date],params[:Heure],params[:message]]  
      redirect_to recapitulatif_spa_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

# --------------------- VIEW RECAPITULATIF COMMANDE ------------------- #
def spa_recapitulatif

end

# ------------------------- SAVE IN TABLE IF PAYED ----------------------- #
def spa_pay_reservation
    # Amount in cents
    @amount = (@priceTotal*100+2000).to_i
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Payment pour lutilisateur no 1',
      currency: 'eur',
    })
      # Enregistrement des valeur dans la table Commande"
      # table order
      client = Client.first # normalement current_user
      order = Order.create(client: client,service: @subPrestations[0][0].category.service)
      order.date = @date
      order.hours = @heure
      order.adresse = @adresse
      order.message = @message
      order.department = @departement
      order.save
      # table en relation pour la prestations
      orderCategory = OrderCategory.create(order: order, category: @subPrestations[0][0].category)
      @subPrestations.each do |sub|
        orderCategory.subcategories.push(sub[0])
      end
      # Ajouts des type de logement / maison ... a développer
      @produitList.each do |produit|
        OrderProduct.create(number: produit[0], product: produit[1], order: order)
      end
      session[:prestations] = nil
      session[:information] = nil

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to recapitulatif_spa_path
    end

# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #

private
# --------------------INDEXINDEXINDEXINDEXINDEXINDEXINDEX-------------------- #
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
      return current_price.round(2)
    end
    # for befor_action
    def index_validate_session
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
    end
# -------------------- SPASPASPASPASPASPASPASPASPASPASPASPASPA ----------------- #
    def totalPriceSpa(prestations,produits) # [[Subcategory.find(sub[0]),info]]
      current_price = 0
      prestations.each do |sub| # [4,"5,4"] "  " soucategory
        current_price += sub[0].price
      end
      produits.each do |produit| # [nb,objet_produit]
        current_price += produit[0]*produit[1].price
      end
      return current_price.round(2)
    end
    # for befor_action
    def spa_validate_session
      if session[:prestations] == nil || session[:information] == nil
        redirect_to root_path
      else
        @subPrestations = []
        session[:prestations][0].each do |sub|
          info = []
          if sub[1][0] == "0"
            info.push("Appartement")
          else
            info.push("Villa - Maison")
          end

          if sub[1][1] == "0"
            info.push("Intérieur")
          else
            info.push("Extérieur")
          end

          if sub[1][2] == "0"
            info.push("Cumulus - Ballon d'eau (eau chaude limitée)")
          else
            info.push("Chaudière (eau chaude continue)")
          end
          @subPrestations.push([Subcategory.find(sub[0]),info])
        end
        @produitList = []
        session[:prestations][1].each do |produit| #[n,produit_id.to_i]
          @produitList.push([produit[0],Product.find(produit[1])])
        end
        # ---------------------- Information -------------
        information = session[:information]
        @departement = Department.find(information[0])
        @pays = @departement.country
        @adresse = information[1]
        @date = information[2]
        @heure = information[3]
        @message = information[4]
        @priceTotal = totalPriceSpa(@subPrestations,@produitList)
      end
    end
  end
