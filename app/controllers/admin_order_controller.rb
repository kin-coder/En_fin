class AdminOrderController < Application2Controller
	before_action :authenticate_admin!
  #page d'accueill pour liste des commandes
  def index
  end
  # affichage d'une commande 
  def show
  end

  def edit
  end
end
