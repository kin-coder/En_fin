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
      if order.in_progress? && order.is_canceled == false && order.prestataire_affected == false
        @orders_in_progress.push(order)
      end
      if order.is_canceled == false && order.prestataire_affected == true
        @orders_progress.push(order)
      end
      if (order.is_canceled == true) || (order.prestataire_affected == false && order.in_progress? == false)
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
