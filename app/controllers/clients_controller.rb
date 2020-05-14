class ClientsController < ApplicationController
  before_action :authenticate_client!

  def personalInfo
    @client = current_client
  end

  def profil #list de tous les commande
  	@client = current_client
    @order_lists = @client.orders.where(is_validate:true)
    @orders_progress = @order_lists.where(status_order:'traitée')
    @orders_not_progress = @order_lists.where(status_order:'non traitée')
    @orders_in_progress = @order_lists.where(status_order:'en cours')
  end

  def order #show d'une order
    @order = Order.find(params[:id])

    # pour avoir l'heure de chaque prestation
    @service_spa = @order.order_services.where(service_id:'2')
    @service_massage = @order.order_services.where(service_id:'1')

    if @order.client.id != current_client.id
      redirect_to client_profil_path
    end
  end

end
