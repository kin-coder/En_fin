class ClientsController < ApplicationController
  before_action :authenticate_client!

  def personalInfo
    @client = current_client
  end

  def profil #list de tous les commande
  	@client = current_client
    @order_lists = @client.orders

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

  def order #show d'une order
    @order = Order.find(params[:id])
    if @order.client.id != current_client.id
      redirect_to client_profil_path
    end
  end

end
