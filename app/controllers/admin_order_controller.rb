class AdminOrderController < Application2Controller
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  def index
    @orders = Order.all
  end

  def show
    @priceTotal = 0
    @orderlist = @order.order_categories
    @orderlist.each do |cat|
      cat.subcategories.each do |sub|
        @priceTotal += sub.price
      end
    end
    #Le prestataires qui va faire la prestation
    @prestatairesAccepted = nil
    a = @order.prestataire_orders.where(accepted:true)
    unless a.empty?
      @prestatairesAccepted = a[0].prestataire
    end
    #les prestataires dans la liste d'attente
    list_presta2 = @order.prestataire_orders.where(accepted:false)
    @prestatairesWaiting = []
    list_presta2.each do |b|
      @prestatairesWaiting.push(b.prestataire)
    end
    #Tous les prestataires qui son encores libre
    @all_prestataires = (@order.department.prestataires & @order.service.prestataires) - ([@prestatairesAccepted] + @prestatairesWaiting)
  end

  def edit
  end

  def update
    value_params = params.require(:order).permit(:datetime, :adresse, :description)
    @order.update(value_params)
    redirect_to show_admin_order_path(@order.id)
  end

  def destroy
    @order.destroy
    redirect_back(fallback_location: root_path)
  end

  def accept
    add = params.permit(:order,:presta)
    ecommande = PrestataireOrder.find_by(order_id: add[:order], prestataire_id: add[:presta])
    if ecommande
      PrestataireOrder.where(order_id: add[:order]).update(accepted:false)
      ecommande.update(accepted: true)
    else
      PrestataireOrder.where(order_id: add[:order]).update(accepted:false)
      PrestataireOrder.create(order_id: add[:order], prestataire_id: add[:presta], accepted: true)
    end
    redirect_back(fallback_location: root_path)
  end

  def waiting
    add = params.permit(:order,:presta)
    ecommande = PrestataireOrder.find_by(order_id: add[:order], prestataire_id: add[:presta])
    if ecommande 
      ecommande.update(accepted: false)
    else
      PrestataireOrder.create(order_id: add[:order], prestataire_id: add[:presta])
    end
    redirect_back(fallback_location: root_path)
  end

  def remove_order
    add = params.permit(:order,:presta)
    ecommande = PrestataireOrder.find_by(order_id: add[:order], prestataire_id: add[:presta])
    ecommande.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

end
