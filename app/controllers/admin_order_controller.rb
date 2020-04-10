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

    @prestataire_orders = []
    @order.services.each do |service|
      @prestataire_orders += service.prestataires.ids
    end
    @prestataire_orders = @prestataire_orders.uniq

    if @order.department.nil?
      @prestataire_orders = @prestataire_orders & @order.country.prestataires.ids
    else
      @prestataire_orders = @prestataire_orders & @order.department.prestataires.ids
    end

    @prestataire_orders = Prestataire.where(id:@prestataire_orders)


#@prestataire_orders.joins(:countries).where(countries:{name:"Belgique"})
#Prestataire.where(id:ps.ids)
#irb(main):209:0> b = Order.last.services[1].prestataires.ids
#irb(main):019:0> Prestataire.joins(:services).where(services:{id:[1,2]})
#Book.joins(:comments).where("comments.id = 2") #version string

  end

  def edit
  end
end
