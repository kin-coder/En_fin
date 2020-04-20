class AdminOrderController < Application2Controller
	before_action :authenticate_admin!
  # page d'accueill pour liste des commandes
  def index
  	@order_lists = Order.all
    @orders_in_progress = []    #en cours
    @orders_progress = []       #traité
    @orders_not_progress = []   #non traité
    @order_lists.each do |order|
      if order.is_canceled == false && order.is_done == false && order.is_future? == true
        @orders_in_progress.push(order)
      end
      if order.is_canceled == false && order.is_done == true
        @orders_progress.push(order)
      end
      if (order.is_canceled == true) || (order.is_done == false && order.is_future? == false)
        @orders_not_progress.push(order)
      end
    end
  end

  # affichage d'une commande
  def show
    @order = Order.find(params[:id])
    # list des prestataire invité
    @massage_prestataires = []
    @spa_prestataires = []
    # list des prestataire qui on répondu à l'invitation
    @massage_result_prestataire = []
    @spa_result_prestataire = []
    # ~~~~ 
    @order.services.each do |service|
      if @order.department.nil?
        tmpPrestataires = Prestataire.joins(:services).where(services:{name:service.name}).joins(:countries).where(countries:{name:@order.country.name})
      else
        tmpPrestataires = Prestataire.joins(:services).where(services:{name:service.name}).joins(:departments).where(departments:{name:@order.department.name})
      end
      if service.name == "Massage"
        if @order.praticien == "all"
          @massage_prestataires = tmpPrestataires
        else
          @massage_prestataires = tmpPrestataires.where(sexe:@order.praticien)
        end
        @massage_result_prestataire = @order.order_services.find_by(service_id:service.id).prestataire_orders
      elsif service.name == "Location spa"
        @spa_prestataires = tmpPrestataires
        @spa_result_prestataire = @order.order_services.find_by(service_id:service.id).prestataire_orders
      end
    end
  end

  def afect_prestataire
    @prestataire = Prestataire.find(params[:id])
    @order = Order.find(params[:order_id])
    case params[:name]
    when "spa"
      @order.order_services.find_by(service_id:Service.find_by_name("Location spa").id).update(prestataire:@prestataire)
      @order.order_services.find_by(service_id:Service.find_by_name("Location spa").id).prestataire_orders.where(prestataire_id:@prestataire.id).destroy_all
    when "massage"
      @order.order_services.find_by(service_id:Service.find_by_name("Massage").id).update(prestataire:@prestataire)
      @order.order_services.find_by(service_id:Service.find_by_name("Massage").id).prestataire_orders.where(prestataire_id:@prestataire.id).destroy_all
    else
    end
    flash[:sucess] = "Le nouveau prestataire a été afecter à la commande"
    redirect_to admin_order_show_path(@order.id)
  end

  def delete_prestataire
    @prestataire = Prestataire.find(params[:id])
    @order = Order.find(params[:order_id])
    case params[:name]
    when "spa"
      @order.order_services.find_by(service_id:Service.find_by_name("Location spa").id).update(prestataire:nil)
    when "massage"
      @order.order_services.find_by(service_id:Service.find_by_name("Massage").id).update(prestataire:nil)
    else
    end
    flash[:sucess] = "Le prestataire a bien été retirer de la commande"
    redirect_to admin_order_show_path(@order.id)
  end
end
