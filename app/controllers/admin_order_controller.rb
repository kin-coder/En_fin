class AdminOrderController < Application2Controller
	before_action :authenticate_admin!
  #page d'accueill pour liste des commandes
  def index
  	order_lists = Order.all
    @orders = []
    order_lists.each do |order|
      if order.in_progress? && order.is_canceled == false && order.prestataire_affected == false
        @orders.push(order)
      end
    end
  end

  def filtreIndex
    filtre = params[:short].to_i
    order_lists = Order.all
    @orders = []
    if filtre == 1 # Traitées
      order_lists.each do |order|
        if order.is_canceled == false && order.prestataire_affected == true
          @orders.push(order)
        end
      end
    else # 0 Non traitées
      order_lists.each do |order|
        if (order.is_canceled == true) || (order.prestataire_affected == false && order.in_progress? == false)
          @orders.push(order)
        end
      end
    end
    respond_to do |format|
      format.js do
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
