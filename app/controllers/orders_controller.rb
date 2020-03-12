class OrdersController < ApplicationController
  before_action :validate_session, only: [:delivery,:saveDelivery,:summary,:payment]
  before_action :validate_value_in_session, only: [:summary,:payment]
  # 1/2 Selection des prestation
  def zone
    @country = params[:country]
    @department = params[:department]
    @date = params[:date]
    if @date
      unless @date[2] == "/" && @date[5] == "/" && @date.length == 10
        redirect_to reservation_path
        return
      end
    else
      redirect_to reservation_path
    end

    @country = Country.find_by(name:@country)
    unless @country
      redirect_to reservation_path
    end

    if @department
      @department = Department.find_by(name:@department)
      unless @department
        redirect_to reservation_path   
      end
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
          flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
          isError = true
        end
        tmp["type"] = params[:typeSpa][k]

        if params[:optionSpa]
          options = params[:optionSpa][k]
          tmpOption = []
          if options
            options.each do |option|
              product = Product.find_by(name:option)
              if product
                tmpOption.push([option,product.price])
              else
                flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
                isError = true
              end
            end
            tmp["option"] = tmpOption
          end
        end
        if isError
          redirect_back(fallback_location: root_path)
          return
        end
        orderSpa.push(tmp)
      end
      if params[:heureSpa] == ""
        flash[:notice] = "Velliez indiquer l'heur de votre réservation de spa"
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
            flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
            isError = true
          end
        else
          flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
          isError = true
        end

        if params[:massageSuPrice] && params[:massageSuPrice][k]
          price = MassageSuPrice.find_by(duration:params[:massageSuPrice][k][0].to_i)
          if price
            if exceptionalDate.include?(current_date[0..1])
              tmp["price"] = [price.id,price.exceptional_price,price.exceptional_acompte]
            else
              tmp["price"] = [price.id,price.ordinary_price,price.ordinary_acompte]
            end
          else
            flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
            isError = true
          end
        else
          flash[:notice] = "Remplisser bien les champs avant de valider"
          isError = true
        end

        if isError
          redirect_back(fallback_location: root_path)
          return
        end
        orderMassage.push(tmp)
      end
      if params[:heureMassage] == ""
        flash[:notice] = "Velliez indiquer l'heur de votre réservation de massage"
        redirect_back(fallback_location: root_path)
        return
      end

      unless params[:praticien]
        flash[:notice] = "Velliez indiquer quelle praticien pour votre massages"
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
    @order = Order.new
    @order.prestation_date = session[:otherInfo]["date"]
    @order.billing_pays = session[:otherInfo]["countryF"]
    @order.billing_ville = session[:otherInfo]["villeF"]
    @order.billing_code_postal = session[:otherInfo]["codePostaF"]
    @order.billing_adresse = session[:otherInfo]["adresseF"]
    @order.billing_adresse_complet = session[:otherInfo]["complAdresseF"]
    @order.delivery_pays = session[:otherInfo]["countryL"]
    @order.delivery_ville = session[:otherInfo]["villeL"]
    @order.delivery_code_postal = session[:otherInfo]["codePostaL"]
    @order.delivery_adresse = session[:otherInfo]["adresseL"]
    @order.delivery_adresse_complet = session[:otherInfo]["complAdresseL"]
    @order.message = session[:otherInfo]["message"]
    @order.client = Client.first
    @order.department = Department.find_by(name:session[:otherInfo]["department"])
    @order.country = Country.find_by(name:session[:otherInfo]["pays"])
    @order.save

    myPrestation = session[:myPrestation]
    unless myPrestation["spa"].empty?
      OrderService.create(order: @order, service: Service.find_by(name:"Location spa"), service_time: session[:otherInfo]["heureSpa"])
      myPrestation["spa"].each do |spa|
        current_spa = Spa.find_by(duration:spa["time"])
        current_product = ""
        if spa["option"]
          current_product = Product.find_by(name:spa["option"][0])
          OrderSpa.create(logement: spa["type"][0], installation: spa["type"][1], syteme_eau: spa["type"][2], order: @order, spa: current_spa, product: current_product)
        else
          OrderSpa.create(logement: spa["type"][0], installation: spa["type"][1], syteme_eau: spa["type"][2], order: @order, spa: current_spa)
        end
      end
    end
    
    unless myPrestation["massage"].empty?
      OrderService.create(order: @order, service: Service.find_by(name:"Massage"), service_time: session[:otherInfo]["heureMassage"])
      myPrestation["massage"].each do |massage|
        current_ca = MassageCa.find_by(name:massage["ca"])      
        current_su = current_ca.massage_sus.find_by(name:massage["su"])
        current_prix = MassageSuPrice.find(massage["price"][0].to_i)
        OrderMassage.create(order: @order, massage_ca:current_ca, massage_su: current_su, massage_su_price: current_prix)
      end
      @order.praticien = session[:otherInfo]["praticien"]
      @order.save
    end
    
    unless session[:otherInfo]["cadeau"].empty?
      session[:otherInfo]["cadeau"].each do |cadeau|
        current_product = Product.find_by(name:cadeau[0])
        OrderProduct.create(number: cadeau[2].to_i, product: current_product, order: @order)
      end
    end

  end

  private

  def redirect_reservation
    flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
    flash[:delete_js] = true
    redirect_to reservation_path
    session.clear
  end

  def validate_session
    if session[:myPrestation] == nil || session[:otherInfo] == nil
      redirect_reservation
    end
    unless session[:otherInfo]["date"]
      redirect_reservation
    end
  end

  def validate_value_in_session
    myPrestation = session[:myPrestation]
    unless myPrestation["spa"].empty?
      myPrestation["spa"].each do |spa|
        current_spa = Spa.find_by(duration:spa["time"])
        unless current_spa
          redirect_reservation
        end
        if spa["option"]
          current_product = Product.find_by(name:spa["option"][0])
          unless current_product
            redirect_reservation
          end
        end
      end
      unless session[:otherInfo]["heureSpa"]
        redirect_reservation
      end
    end
    unless myPrestation["massage"].empty?
      myPrestation["massage"].each do |massage|
        current_ca = MassageCa.find_by(name:massage["ca"])
        if current_ca
          current_su = current_ca.massage_sus.find_by(name:massage["su"])
          unless current_su
            redirect_reservation
          end
        else
          redirect_reservation
        end
        # pour le prix
        current_prix = MassageSuPrice.find(massage["price"][0].to_i)
        unless current_prix
          redirect_reservation
        end
      end
      unless session[:otherInfo]["praticien"]
        redirect_reservation
      end
      unless session[:otherInfo]["heureMassage"]
        redirect_reservation
      end
    end
    unless session[:otherInfo]["cadeau"].empty?
      session[:otherInfo]["cadeau"].each do |cadeau|
        current_product = Product.find_by(name:cadeau[0])
        unless current_product
          redirect_reservation
        end
      end
    end
  end

end
