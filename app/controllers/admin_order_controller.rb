class AdminOrderController < Application2Controller
	before_action :authenticate_admin!
  #page d'accueill pour liste des commandes
  def index
  	@orders = Order.all
    # @order = Order.first
    # @order.prestation_date
    # @order.billing_pays
    # @order.billing_ville
    # @order.billing_code_postal
    # @order.billing_adresse
    # @order.billing_adresse_complet
    # @order.delivery_pays
    # @order.delivery_ville
    # @order.delivery_code_postal
    # @order.delivery_adresse
    # @order.delivery_adresse_complet
    # @order.message #message
    # @order.client #objet client
    # @order.department #objet department
    # @order.country #objet country
    # @order.praticien #si massage pratitient
  end

  def filtreIndex
  	
  end
  # affichage d'une commande 
  def show
  end

  def edit
  end
end
