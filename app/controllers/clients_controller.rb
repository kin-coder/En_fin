class ClientsController < ApplicationController
  before_action :authenticate_client!

  def personalInfo
    @client = current_client
  end

  def profil #list de tous les commande
  	@client = current_client
    order_lists = @client.orders
    @orders = []
    order_lists.each do |order|
      if order.in_progress? && order.is_canceled == false && order.prestataire_affected == false
        @orders.push(order)
      end
    end
  end

  def filtreIndex
    filtre = params[:short].to_i
    @client = current_client
    order_lists = @client.orders
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

  def order #show d'une order
    @order = Order.find(params[:id])
    if @order.client.id != current_client.id
      redirect_to client_profil_path
    end
  end

end
