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
  end

  def edit
  end
end
