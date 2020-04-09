class ClientsController < ApplicationController
  before_action :authenticate_client!

  def profil
  	@client = current_client
  	@orders = @client.orders
  end

  def order
  	@order = Order.find(params[:id])
  	if @order.client.id != current_client.id
  		redirect_to client_profil_path
  	end
  end
  
end
