class OrdersController < ApplicationController
  before_action :authenticate_client!, only: [:delivery,:saveDelivery,:summary,:payment,:payedsuccess,:payederrors]
  protect_from_forgery except: :payment
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def zone
    @country = params[:country]
    @department = params[:department]
    @date = params[:date]
    @error = ""
    @services = []
    results = validate_country_department_date(@country,@department,@date)
    if results[0]
      @country = results[1]
      @department = results[2]
      if results[2] === ""
        @country.services.each do |s|
           @services.push(s.name)
        end
      else
        @department.services.each do |s|
          @services.push(s.name)
        end
      end
    else
      @error = "Une errerur est survernue"
    end
    respond_to do |format|
      format.js
    end
  end
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def code_promo
    parameters = params.permit(:code)
    @test = false
    @code = CodePromo.all.find_by(code:parameters[:code])
    @code_value = ["",0]
    if @code
      @code_value[0] = @code.code
      @code_value[1] = @code.reduction
      @test = true
    end
    respond_to do |format|
       format.js
    end
  end
# 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def index
    session.delete(:spas)
    session.delete(:man)
    session.delete(:woman)
    session.delete(:info)
    session.delete(:order)
    @countries = Country.all
    @departments = Department.all
    @massagesDuration = MassageDurationPrice.all
    @spas = Spa.all
    @spa_ambiances = SpaAmbiance.all
    @massageTypes = MassageType.all
  end
# 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def saveSession
    error = ""
    messageErrore = []
    date = params[:date]
    pays = params[:pays]
    department = params[:department]
    code_promo = params[:code_promo]
    pays = Country.find_by_name(params[:pays])
    if pays.nil? || params[:date].length != 10
      error = "Une erreur c'est prouduit lors de la verification des données"
    else
      if pays.name == "France"
        department = Department.find_by_name(params[:department])
        if department.nil?
          error = "Une erreur c'est prouduit lors de la verification des données"
        else
          department = department.name
        end
      end
    end
    prestations_spas = {}
    heure_spa = params[:heureSpa]
    unless params[:spas].nil?
      if heure_spa.length == 0
        messageErrore.push("Velliez indiquer l'heur de votre réservation de spa")
      end
      params[:spas].each do |index,spa|
        unless spa["type"].nil? || spa["time"].nil?
          prestations_spas[index] = {}
          unless spa["ambiance"].nil?
            ambiance_spa = SpaAmbiance.find_by_name(spa["ambiance"])
            if ambiance_spa.nil?
              error = "Une erreur c'est prouduit lors de la verification des données"
            else
              prestations_spas[index]["a"] = ambiance_spa.id
            end
          end
          time_spa = Spa.find_by_duration(spa["time"])
          if time_spa.nil?
            error = "Une erreur c'est prouduit lors de la verification des données"
          else
            prestations_spas[index]["t"] = time_spa.id
          end
          prestations_spas[index]["type"] = spa["type"]
        end
      end
    end
    heure_massage = params[:heureMassage]
    praticien = params[:praticien]
    prestations_massage_man = {}
    prestations_massage_woman = {}
    unless params[:man].nil? && params[:woman].nil?
      if heure_massage.nil? || heure_massage.length == 0
        messageErrore.push("Velliez indiquer l'heur de votre réservation de massage")
      end
      if praticien.nil? || praticien.length == 0
        messageErrore.push("Velliez indiquer quelle praticien pour votre massages")
      end
    end
    unless params[:man].nil?
      params[:man].each do |index,massages|
        prestations_massage_man[index] = []
        massages.each do |massage_type|
          massageType = massage_type.split("||")
          duration = MassageDurationPrice.find_by_duration(massageType[1])
          unless duration.nil?
            tmp_massage = duration.massage_types.find_by_name(massageType[0])
            if tmp_massage.nil?
              error = "Une erreur c'est prouduit lors de la verification des données"
            else
              prestations_massage_man[index].push([duration.id,tmp_massage.id])
            end
          else
            error = "Une erreur c'est prouduit lors de la verification des données"
          end
        end
      end
    end
    unless params[:woman].nil?
      params[:woman].each do |index,massages|
        prestations_massage_woman[index] = []
        massages.each do |massage_type|
          massageType = massage_type.split("||")
          duration = MassageDurationPrice.find_by_duration(massageType[1])
          unless duration.nil?
            tmp_massage = duration.massage_types.find_by_name(massageType[0])
            if tmp_massage.nil?
              error = "Une erreur c'est prouduit lors de la verification des données"
            else
              prestations_massage_woman[index].push([duration.id,tmp_massage.id])
            end
          else
            error = "Une erreur c'est prouduit lors de la verification des données"
          end
        end
      end
    end
    if messageErrore.length != 0 || error.length != 0
      if messageErrore.length != 0
        flash[:danger] = messageErrore
      end
      if error.length != 0
        flash[:danger] = messageErrore.push(error)
      end
      redirect_back(fallback_location: root_path)
    else
      if prestations_spas == {} && prestations_massage_man == {} && prestations_massage_woman == {}
        flash[:danger] = messageErrore.push(" Veillez selectioner au moin une presatations! ")
        redirect_back(fallback_location: root_path)
      else
        session[:spas] = prestations_spas
        session[:man] = prestations_massage_man
        session[:woman] = prestations_massage_woman        
        session[:info] = {date: date, pays: pays.name, department: department, code_promo: code_promo, heure_spa: heure_spa, heure_massage: heure_massage, praticien: praticien}
        redirect_to delivery_path
      end
    end
  end
# 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def delivery
    @client = current_client
    @countries = Country.all
  end
# 4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def saveDelivery
    prestations_spas = session[:spas]
    prestations_massage_man = session[:man]
    prestations_massage_woman = session[:woman]
    prestations_info = session[:info]
    emptyIsInclude = params[:adresseL]=="" || params[:codePostaL]=="" || params[:villeL]=="" || params[:adresseF]=="" || params[:codePostaF]=="" || params[:villeF] =="" || params[:countryL]=="" || params[:countryF]=="" || params[:countryL]==nil || params[:countryF]==nil
    if emptyIsInclude
      redirect_back(fallback_location: root_path)
      return
    end
    @order = Order.new
    @order.prestation_date = prestations_info["date"]
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
    @order.department = Department.find_by(name:prestations_info["department"])
    @order.country = Country.find_by(name:prestations_info["pays"])
    code_promo = CodePromo.find_by_code(prestations_info["code_promo"])
    unless code_promo.nil?
      @order.code_promo = "#{code_promo.code}-|-#{code_promo.reduction}"
    end
    @order.save
    unless prestations_spas == {}
      OrderService.create(order: @order, service: Service.find_by(name:"Location spa"), service_time: prestations_info["heure_spa"])
      @order.update(is_spa:true)
      prestations_spas.each do |index,spa|
        current_spa = Spa.find(spa["t"])
        current_ambiance = nil
        unless spa["a"].nil?
          current_ambiance = SpaAmbiance.find(spa["a"])
        end
        OrderSpa.create(order: @order, spa: current_spa, spa_ambiance: current_ambiance, logement: spa["type"][0], installation: spa["type"][1], syteme_eau: spa["type"][2])
      end
    end
    if prestations_massage_man != {} || prestations_massage_woman != {}
      OrderService.create(order: @order, service: Service.find_by(name:"Massage"), service_time: prestations_info["heure_massage"])
      @order.update(is_massage:true)
      @order.update(praticien:prestations_info["praticien"])
    end
    unless prestations_massage_man == {}
      massage_man = Massage.find_by_name("Homme")
      prestations_massage_man.each do |index,massages|
        order_massage = OrderMassage.create(order:@order, massage: massage_man)
        massages.each do |massage_type|
          current_type = MassageType.find(massage_type[1])
          current_price = MassageDurationPrice.find(massage_type[0])
          OrderMassageType.create(order_massage: order_massage, massage_type: current_type, massage_duration_price: current_price)
        end
      end
    end
    unless prestations_massage_woman == {}
      massage_woman = Massage.find_by_name("Femme")
      prestations_massage_woman.each do |index,massages|
        order_massage = OrderMassage.create(order:@order, massage: massage_woman)
        massages.each do |massage_type|
          current_type = MassageType.find(massage_type[1])
          current_price = MassageDurationPrice.find(massage_type[0])
          OrderMassageType.create(order_massage: order_massage, massage_type: current_type, massage_duration_price: current_price)
        end
      end
    end
    session[:order] = @order.id
    redirect_to summary_path
  end
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ééé
  # 3 Affiche la recapitulatif de commande
  def summary
    @order = Order.find(session[:order])
    unless @order.nil?
      unless @order.client == current_client && @order.is_validate == false
        error = "Une erreur c'est prouduit lors de la verification des données"
      end
    else
      error = "Une erreur c'est prouduit lors de la verification des données"
    end
    @time_spa = ""
    @time_massage = ""
    if @order.is_spa
      @time_spa = @order.order_services.find_by(service:Service.find_by_name("Location spa")).service_time
    end
    if @order.is_massage
      @time_massage = @order.order_services.find_by(service:Service.find_by_name("Massage")).service_time
    end
    current_price = @order.totalPrice
    @totalPrice = current_price[0].to_i
    @totalAcompte = current_price[1].to_i
    @amount = @totalAcompte*100
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

  def payment
    @order = current_client.orders.order('id ASC').last
    data = params['Data'].split('|')
    data.each do |params|
      if params.include?("paymentMeanBrand")
        @order.update(paymentMeanBrand:params.split("=")[1])
      end

      if params.include?("transactionDateTime")
        @order.update(transactionDateTime:params.split("=")[1])
      end

      if params.include?("amount")
        @order.update(acompte_amount:params.split("=")[1])
      end
    end
    if data.include?("responseCode=00")
      # =============================== Enregistrement des commandes si payer Mila amboarina ny mailer
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
    session.delete(:spas)
    session.delete(:man)
    session.delete(:woman)
    session.delete(:info)
    session.delete(:order)
  end

  def payederrors
    session.delete(:spas)
    session.delete(:man)
    session.delete(:woman)
    session.delete(:info)
    session.delete(:order)
  end

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

  private

  def validate_country_department_date(country,department,date)
    services = []
    country = Country.find_by(name:country)
    if country
      if country.name == "France"
        department = Department.find_by(name:department)
        unless department
          return [false]
        end
      else
        department = ""
      end
    else
      return [false]
    end
    if date
      unless @date[2] == "/" && @date[5] == "/" && @date.length == 10
        return [false]
      end
    else
      return [false]
    end
    return [true,country,department]
  end
end
