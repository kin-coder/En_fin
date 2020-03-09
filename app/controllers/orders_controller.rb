class OrdersController < ApplicationController
  # 1/2 Selection des prestation
  def zone
    @country = params[:country]
    @department = params[:department]
    @date = params[:date]
    @country = Country.find_by(name:@country)
    if @department
      @department = Department.find_by(name:@department)  
    else
      @department = nil
    end
    @services = []
    @error = ""
    if @country
      if @country.name == "France"
        if @department != nil
          @country = @country.name
          @department.services.each do |s|
            @services.push(s.name)
          end
          @department = @department.name
          unless session[:otherInfo]
            session[:otherInfo]={}
          end
          session[:otherInfo]["pays"] = @country
          session[:otherInfo]["department"] = @department
          session[:otherInfo]["date"] = @date
          
        else
          @error = "Veuillez choisir un département" #erreur
          #redirect_back(fallback_location: root_path)
        end
      else
        @country.services.each do |s|
            @services.push(s.name)
        end
        @country = @country.name
        @department = ""

        unless session[:otherInfo]
          session[:otherInfo]={}
        end
        session[:otherInfo]["pays"] = @country
        session[:otherInfo]["department"] = @department
        session[:otherInfo]["date"] = @date
      end
    else
      @error = "Veuillez choisir un pays" #erreur
      #redirect_back(fallback_location: root_path)
    end

    respond_to do |format|
       format.js
    end

  end

  
  def code_promo
    parameters = params.permit(:code)
    @code = parameters[:code]
    @test = false
    if CodePromo.all.find_by(code:@code)
      @test = true
      session[:otherInfo]["code_promo"] = @code
    else
      session[:otherInfo]["code_promo"] = ""
    end
    respond_to do |format|
       format.js
    end
  end
  # 1/2 Selection des prestation
  def index
    @countries = Country.all
    @departments = Department.all
    @services = Service.all
    # service location spa
    @spas = []
    tmpspa = Spa.all
    tmpspa.each do |spa|
      @spas.push([spa.duration,spa.exceptional_price,spa.ordinary_price,spa.exceptional_acompte,spa.ordinary_acompte])
    end
    # options pour location spa
    @spaoptions = []
    tmpoption = Product.where(is_option_spa:true)
    tmpoption[0..2].each do |option|
      @spaoptions.push([option.id,option.name,option.price])
    end
    # service massage
    @massages = []
    #.massage_sus liste sub sub[0].massage_su_prices //differen heurse
    caMassages = MassageCa.all
    # sou massage_ca Name  || massage_su Name ||
    caMassages.each do |ca|
      isCa = [ca.name,[]]
      ca.massage_sus.each do |su|
        isSu = [su.name,[]]
        su.massage_su_prices.each do |price|
          isSu[1].push([price.duration,price.exceptional_price,price.exceptional_acompte,price.ordinary_price,price.ordinary_acompte])
        end
        isCa[1].push(isSu)
      end
      @massages.push(isCa)
    end
    @cadeaus = Product.where(is_option_spa:false)
    # ========================================== #
  end

  # 2/2 Sauvegarder dans une session les données
  def saveSession
    # orderSpa = [{time:48,type:["a","b"],price:180,option:[["a",12],["c",45]]},{time:48,type:["a","b"],price:180,option:[["a",12],["c",45]]}]
    # orderMassage =  [{ca:"Homme",su:"prénatal",price:[30,120]}]
    timeSpas = params[:timeSpa]
    orderSpa = []
    isError = false
    
    # gestion de l'heurs pour les prixs MM-DD 
    exceptionalDate = [["02","14"],["12","24"],["12","25"],["12","31"]]
    current_date = session[:otherInfo]["date"].split("/")

    if timeSpas
      timeSpas.each do |k,v|
        tmp = {}
        curent_Spa = Spa.find_by(duration:v[0].to_i)
        if curent_Spa
          tmp["time"] = v[0].to_i
          if exceptionalDate.include?(current_date[0..1])
            tmp["price"] = [curent_Spa.exceptional_price,curent_Spa.exceptional_acompte]
          else
            tmp["price"] = [curent_Spa.ordinary_price,curent_Spa.ordinary_acompte]
          end
        else
          isError = true
        end
        tmp["type"] = params[:typeSpa][k]
        options = params[:optionSpa][k]
        if options
          tmpOption = []
          options.each do |option|
            product = Product.find_by(name:option)
            if product
              tmpOption.push([option,product.price])
            else
              isError = true
            end
          end
          tmp["option"] = tmpOption
        end
        if isError
          flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
          redirect_back(fallback_location: root_path)
          return
        end
        orderSpa.push(tmp)
      end
      if params[:heureSpa] == ""
        flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
        redirect_back(fallback_location: root_path)
        return
      end
    end

    orderMassage = []
    massageSus = params[:massageSu]
    if massageSus
      massageSus.each do |k,v|
        tmp = {}
        mCa = MassageCa.find_by(name:v[0])
        if mCa
          tmp["ca"] = v[0]
          mSu = mCa.massage_sus.find_by(name:v[1])
          if mSu
            tmp["su"] = v[1]
          else
            isError = true
          end
        else
          isError = true
        end
        if params[:massageSuPrice]
          price = MassageSuPrice.find_by(duration:params[:massageSuPrice][k][0].to_i)
          if price
            if exceptionalDate.include?(current_date[0..1])
              tmp["price"] = [price.id,price.exceptional_price,price.exceptional_acompte]
            else
              tmp["price"] = [price.id,price.ordinary_price,price.ordinary_acompte]
            end
          else
            isError = true
          end
        else
          isError = true
        end
        if isError
          flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
          redirect_back(fallback_location: root_path)
          return
        end
        orderMassage.push(tmp)
      end
      if params[:heureMassage] == ""
        flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
        redirect_back(fallback_location: root_path)
        return
      end

      unless params[:praticien]
        flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
        redirect_back(fallback_location: root_path)
        return
      end
    end

    allCadeau = []
    if params[:cadeau]
      a_cadeau = params[:cadeau].split("|")
      a_cadeau.each do |c|
        # id: 0 nbr: 1
        infoC = c.split("-")
        produit = Product.find(infoC[0].to_i)
        if produit
          allCadeau.push([produit.name,produit.price,infoC[1].to_i])
        else
          flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
          redirect_back(fallback_location: root_path)
          return
        end
      end
    end

    if orderSpa.empty? && orderMassage.empty?
      flash[:notice] = "Veuillez selectioner au moin une prestation"
      redirect_back(fallback_location: root_path)
      return
    end

    session[:myPrestation] = {spa:orderSpa, massage:orderMassage}
    session[:otherInfo]["heureSpa"] = params[:heureSpa]
    session[:otherInfo]["praticien"] = params[:praticien]
    session[:otherInfo]["heureMassage"] = params[:heureMassage]
    session[:otherInfo]["cadeau"] = allCadeau

    redirect_to delivery_path

  end

  # 2 Selection des adresse de livraison et facturation
  def delivery
    @client = Client.first
    @countries = Country.all
  end

  def saveDelivery
    emptyIsInclude = params[:adresseL]=="" || params[:complAdresseL]=="" || params[:codePostaL]=="" || params[:villeL]=="" || params[:adresseF]=="" || params[:complAdresseF]=="" || params[:codePostaF]=="" || params[:villeF] =="" || params[:message]=="" || params[:countryL]=="" || params[:countryF]=="" || params[:countryL]==nil || params[:countryF]==nil
    if emptyIsInclude
      redirect_back(fallback_location: root_path)
    else
      session[:otherInfo]["adresseL"] = params[:adresseL]
      session[:otherInfo]["complAdresseL"] = params[:complAdresseL]
      session[:otherInfo]["codePostaL"] = params[:codePostaL]
      session[:otherInfo]["villeL"] = params[:villeL]
      session[:otherInfo]["countryL"] = params[:countryL]
      session[:otherInfo]["adresseF"] = params[:adresseF]
      session[:otherInfo]["complAdresseF"] = params[:complAdresseF]
      session[:otherInfo]["codePostaF"] = params[:codePostaF]
      session[:otherInfo]["villeF"] = params[:villeF]
      session[:otherInfo]["countryF"] = params[:countryF]
      session[:otherInfo]["message"] = params[:message]
      redirect_to summary_path
    end
  end

  # 3 Affiche la recapitulatif de commande
  def summary
    
    
  end

  # 4 Le Payement
  def payment
    
  end


end





























=begin

# massages = params[:massageSu]["3"]
# puts "~~~~"*10
# puts massages[0].split("||")
# puts "~~~~"*10

JSON.parse("Text to Data") // mamadika ny text ho data 

JSON.stringify(Data) // mamadika ny data ho text


@services = Service.all
# service location spa
@spas = Spa.all
@spaoptions = Product.where(is_option_spa:true)
# service massage
@massages = MassageCa.all #.massage_sus liste sub sub[0].massage_su_prices //differen heurse
@cadeaus = Product.where(is_option_spa:false)


# @categories = @service.categories # Liste de tous les categories

# @products = @service.products # Liste de tous les produits

# @listPrestation = []

# @categories.each do |c|

#   @listPrestation.push([[c.name,c.id]])

#   c.subcategories.each do |s|
#     @listPrestation[@listPrestation.length-1].push([s.id,s.name,s.price])
#   end

# end

# <%= form_tag(saved_commande_path, id:"form", 'data-zones':"#{@listPrestation}", 'data-service':"#{@service.name}") do %>

get 'orders/zone'
  get 'orders/order'

rails g controller Orders zone order
Running via Spring preloader in process 4988
      create  app/controllers/orders_controller.rb
       route  get 'orders/zone'
get 'orders/order'
      invoke  erb
      create    app/views/orders
      create    app/views/orders/zone.html.erb
      create    app/views/orders/order.html.erb
      invoke  test_unit
      create    test/controllers/orders_controller_test.rb
      invoke  helper
      create    app/helpers/orders_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/orders.scss
=end
