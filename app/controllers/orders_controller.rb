class OrdersController < ApplicationController
  protect_from_forgery except: :payment
  before_action :validate_session, only: [:delivery,:saveDelivery,:summary,:payment]
  before_action :validate_value_in_session, only: [:summary,:payment]
  before_action :authenticate_client!, only: [:delivery,:saveDelivery,:summary,:payment]

# ~~~~~~~Accepter une commande par emails~~~~~~~~~~~
  def acceptOrder
    @order_service = OrderService.find_by(confirm_token: params[:os_id].to_s)
    @prestataire = Prestataire.find_by(confirm_token: params[:prestataire_id].to_s)
    if @order_service.nil? || @prestataire.nil?
      redirect_to root_path #si erreur
    end
    if @order_service.prestataire.nil?
      p_o = PrestataireOrder.find_by(order_service:@order_service,prestataire:@prestataire)
      unless p_o.nil?
        p_o.destroy
      end
      @order_service.update(status_order:'traitée',prestataire:@prestataire)
      current_order = @order_service.order
      if current_order.order_services.where(status_order:'en cours').empty? && current_order.order_services.where(status_order:'non traitée').empty?
        current_order.update(status_order:'traitée')
        data_big = {"id":current_order.id,"text":"La commande n°#{current_order.id} a été bien traitée"}
        # crée un notification
        Notification.create(notif_type:1,data:data_big.to_json)
      end
      case @order_service.service.name
        when "Location spa"
          PrestataireMailer.accepted_orderSpa(@order_service.id,@prestataire.id).deliver_now
        when "Massage"
          PrestataireMailer.accepted_orderMassage(@order_service.id,@prestataire.id).deliver_now
        else
      end
      flash[:new] = "Vous ête afecter a cettre prestation"
    elsif @order_service.prestataire.id == @prestataire.id
      flash[:ready] = "Vous faite dejà cette prestation"
    else
      isPresent = PrestataireOrder.where(order_service:@order_service,prestataire:@prestataire)
      if isPresent.empty?
        PrestataireOrder.create(order_service:@order_service,prestataire:@prestataire)
      else
        isPresent[0].update(is_accepted:true)
      end
      flash[:oups] = "Cette prestation est déja prix par un autre prestataire"
      PrestataireMailer.oups_order_not_available(@prestataire.id).deliver_now
    end
  end

  def deniedOrder
    @order_service = OrderService.find_by(confirm_token: params[:os_id].to_s)
    @prestataire = Prestataire.find_by(confirm_token: params[:prestataire_id].to_s)
    if @order_service.nil? || @prestataire.nil?
      redirect_to root_path #si erreur
      return
    end
    if @order_service.prestataire == @prestataire
      flash[:no_refuse] = "Pour annuler votre affectation a cette commande veiller contacer l'administrateur du site"
    else
      flash[:refuse] = "Votre refus a été pris en compte, nous reviendrons vers vous pour de nouvelles commandes."
      isPresent = PrestataireOrder.where(order_service:@order_service,prestataire:@prestataire)
      if isPresent.empty?
        PrestataireOrder.create(is_accepted:false,order_service:@order_service,prestataire:@prestataire)
      else
        isPresent[0].update(is_accepted:false)
      end
    end
  end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
    @test = false
    @code = CodePromo.all.find_by(code:parameters[:code])
    if @code
      @test = true
      session[:otherInfo]["code_promo"] = [@code.code,@code.reduction]
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
    # sou massage_ca Name || massage_su Name ||
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
    exceptionalDate = [["14","02"],["24","12"],["25","12"],["31","12"]]
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

    if orderSpa.empty? && orderMassage.empty?
      flash[:notice] = "Veuillez selectioner au moin une prestation"
      redirect_back(fallback_location: root_path)
      return
    end

    session[:myPrestation] = {spa:orderSpa, massage:orderMassage}
    session[:otherInfo]["heureSpa"] = params[:heureSpa]
    session[:otherInfo]["praticien"] = params[:praticien]
    session[:otherInfo]["heureMassage"] = params[:heureMassage]
    redirect_to delivery_path
  end

  # 2 Selection des adresse de livraison et facturation
  def delivery
    @client = current_client
    @countries = Country.all
  end

  def saveDelivery
    emptyIsInclude = params[:adresseL]=="" || params[:codePostaL]=="" || params[:villeL]=="" || params[:adresseF]=="" || params[:codePostaF]=="" || params[:villeF] =="" || params[:countryL]=="" || params[:countryF]=="" || params[:countryL]==nil || params[:countryF]==nil
    
    puts "======"*3
    puts params.inspect
    puts "======"*3

    if emptyIsInclude
      redirect_back(fallback_location: root_path)
    else
# ==========================  ENREGISTREMENT DES COMMANDE =========    
      @order = Order.new
      @order.prestation_date = session[:otherInfo]["date"]
      @order.billing_pays = params[:countryF]
      @order.billing_ville = params[:villeF]
      @order.billing_code_postal = params[:codePostaF]
      @order.billing_adresse = params[:adresseF]
      @order.billing_adresse_complet = params[:complAdresseF]
      @order.delivery_pays = params[:countryL]
      @order.delivery_ville = params[:villeL]
      @order.delivery_code_postal = params[:codePostaL]
      @order.delivery_adresse = params[:adresseL]
      @order.delivery_adresse_complet = params[:complAdresseL]
      @order.message = params[:message]
      @order.client = current_client
      @order.department = Department.find_by(name:session[:otherInfo]["department"])
      @order.country = Country.find_by(name:session[:otherInfo]["pays"])
      @order.save

      code = session[:otherInfo]["code_promo"]
      if code
        if code.length == 2
          @order.code_promo = CodePromo.find_by_code(session[:otherInfo]["code_promo"][0])
        end
      end

      myPrestation = session[:myPrestation]
      unless myPrestation["spa"].empty?
        mailToOrderServiceSpa = OrderService.create(order: @order, service: Service.find_by(name:"Location spa"), service_time: session[:otherInfo]["heureSpa"])
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
        mailToOrderServiceMassage = OrderService.create(order: @order, service: Service.find_by(name:"Massage"), service_time: session[:otherInfo]["heureMassage"])
        myPrestation["massage"].each do |massage|
          current_ca = MassageCa.find_by(name:massage["ca"])      
          current_su = current_ca.massage_sus.find_by(name:massage["su"])
          current_prix = MassageSuPrice.find(massage["price"][0].to_i)
          OrderMassage.create(order: @order, massage_ca:current_ca, massage_su: current_su, massage_su_price: current_prix)
        end
        @order.praticien = session[:otherInfo]["praticien"]
        @order.save
      end
      redirect_to summary_path
    end
  end

  # 3 Affiche la recapitulatif de commande
  def summary
    @code_promo = 0
    code = session[:otherInfo]["code_promo"]
    if code
      if code.length == 2
        @code_promo = code[1]
      end
    end

    @order = current_client.orders.order('id ASC').last
    @amount = (@totalAcompte*100).to_i
    # Génère un numéro de transaction aléatoire
    transactionReference = "simu" + rand(100000..999999).to_s
    #Construit l'URL de retour pour récupérer le résultat du paiement sur le site e-commerce du marchand
    normalReturnUrl = "http://localhost:3000/reservation-prestation/paye-commande"
    # Contruit la requête des données à envoyer à Mercanet
    @data = "amount=#{@amount}|currencyCode=978|merchantId=002001000000001|normalReturnUrl=" + normalReturnUrl + "|transactionReference=" + transactionReference + "|keyVersion=1"
    # Encode en UTF-8 des données à envoyer à Mercanet
    dataToSend = (@data).encode('utf-8')
    # Clé secrète correspondant au merchandId de simulation
    secretKey = "002001000000001_KEY1"
    # Calcul du certificat par un cryptage SHA256 des données envoyées suffixé par la clé secrète
    @seal = Digest::SHA256.hexdigest dataToSend + secretKey    # MILA JERANA !!
  end

  # 4 Le Payement
  def payment
    data = params['Data'].split('|')
    if data.include?("responseCode=00")
      # =============================== Enregistrement des commandes si payer Mila amboarina ny mailer
      @order = current_client.orders.order('id ASC').last
      @order.update(is_validate:true)
      current_client.update(is_client:true)
      @order.services.each do |service|
        case service.name
          when "Location spa"
            mailToOrderServiceSpa = @order.order_services.find_by(service_id:service.id)
            #====== Send email to prestataire location spa =====
            @prestataires = []
            if @order.department.nil?
              @prestataires = Prestataire.joins(:services).where(services:{name:service.name}).joins(:countries).where(countries:{name:@order.country.name})
            else
              @prestataires = Prestataire.joins(:services).where(services:{name:service.name}).joins(:departments).where(departments:{name:@order.department.name})
            end
            @prestataires.each do |prestataire|
              PrestataireMailer.new_orderSpa(mailToOrderServiceSpa.id,prestataire.id).deliver_now
            end
          when "Massage"
            mailToOrderServiceMassage = @order.order_services.find_by(service_id:service.id)
            #====== Send email to prestataire massage =====
            @prestataires = []
            if @order.department.nil?
              @prestataires = Prestataire.joins(:services).where(services:{name:service.name}).joins(:countries).where(countries:{name:@order.country.name})
            else
              @prestataires = Prestataire.joins(:services).where(services:{name:service.name}).joins(:departments).where(departments:{name:@order.department.name})
            end
            @prestataires.each do |prestataire|
              if prestataire.sexe == @order.praticien || @order.praticien == "all"
                PrestataireMailer.new_orderMassage(mailToOrderServiceMassage.id,prestataire.id).deliver_now
              end
            end
          else
        end
      end
      ClientMailer.confirm_order(@order.id,current_client.id).deliver_now
      redirect_to payedsuccess_path
      # =====================================================================
    else
      redirect_to payederrors_path
    end
  end

  def payedsuccess
    session.delete(:otherInfo)
    session.delete(:myPrestation)
  end

  def payederrors
    session.delete(:otherInfo)
    session.delete(:myPrestation)
  end

  private

  def redirect_reservation(test=true)
    if test
      flash[:notice] = "Une erreur c'est prouduit lors de la verification des données"
    end
    flash[:delete_js] = true
    session.delete(:otherInfo)
    session.delete(:myPrestation)
    redirect_to reservation_path
  end

  def validate_session
    if session[:myPrestation] == nil || session[:otherInfo] == nil
      redirect_reservation(false)
    end
    if session[:otherInfo] != nil
      unless session[:otherInfo]["date"]
        redirect_reservation(false)
      end      
    end
  end

  def validate_value_in_session
    exceptionalDate = [["02","14"],["12","24"],["12","25"],["12","31"]]
    @code_promo = 0
    code = session[:otherInfo]["code_promo"]
    if code
      if code.length == 2
        @code_promo = code[1]
      end
    end
    current_date = session[:otherInfo]["date"].split("/")
    isExeptional = false #[curent_Spa.ordinary_price,curent_Spa.ordinary_acompte]
    if exceptionalDate.include?(current_date[0..1])
      isExeptional = true #[curent_Spa.exceptional_price,curent_Spa.exceptional_acompte]
    end
    @totalPrice = 0
    @totalAcompte = 0
    myPrestation = session[:myPrestation]
    unless myPrestation["spa"].empty?
      myPrestation["spa"].each do |spa|
        current_spa = Spa.find_by(duration:spa["time"])
        unless current_spa
          redirect_reservation
        else
          if isExeptional
            @totalPrice += current_spa.exceptional_price - @code_promo
            @totalAcompte += current_spa.exceptional_acompte - @code_promo
          else
            @totalPrice += current_spa.ordinary_price - @code_promo
            @totalAcompte += current_spa.ordinary_acompte - @code_promo
          end
        end
        if spa["option"]
          current_product = Product.find_by(name:spa["option"][0])
          unless current_product
            redirect_reservation
          else
            @totalPrice += current_product.price
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
        else
          if isExeptional
            @totalPrice += current_prix.exceptional_price - @code_promo
            @totalAcompte += current_prix.exceptional_acompte - @code_promo
          else
            @totalPrice += current_prix.ordinary_price - @code_promo
            @totalAcompte += current_prix.ordinary_acompte - @code_promo
          end
        end
      end
      unless session[:otherInfo]["praticien"]
        redirect_reservation
      end
      unless session[:otherInfo]["heureMassage"]
        redirect_reservation
      end
    end
  end
end
