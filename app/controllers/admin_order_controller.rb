class AdminOrderController < Application2Controller
	before_action :authenticate_admin!
  #page d'accueill pour liste des commandes
  def index
  	@orders = Order.all
  end

  def filtreIndex
  	
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
