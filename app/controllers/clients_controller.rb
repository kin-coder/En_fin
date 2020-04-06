class ClientsController < ApplicationController
  before_action :authenticate_client!

  def profil
  	@client = current_client
  end

  def order
  end
  
end
