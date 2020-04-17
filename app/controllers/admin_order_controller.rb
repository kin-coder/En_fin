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
    @massage_prestataires = []
    @spa_prestataires = []
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
      elsif service.name == "Location spa"
        @spa_prestataires = tmpPrestataires
      end
    end
  end

  def edit
  end
end
