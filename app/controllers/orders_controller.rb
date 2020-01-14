class OrdersController < ApplicationController
  include OrdersHelper
  before_action :param_permit, only: [:addcategory, :delcategory]
  def index
    params.permit(:name)
    @service = is_service(params[:name]) # un objet de type service
    unless @service
      redirect_to root_path
    else
      @categories = @service.categories # Liste de tous les categories
    end
  end

  def addcategory
    @subcategories = @category.subcategories
    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do
      end
    end
  end

  def delcategory
    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do

      end
    end
  end

  def subcategory
    puts "*"*50
    puts params.inspect
    puts "*"*50
    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do

      end
    end
  end



#==================== Tunel d'achat location spa ===============#
  def location_spa_reservation
    if session[:params_spa] == nil
        session[:params_spa] = []
    end

    @params = session[:params_spa]

    @service = Service.where(name:'Location spa')[0]
    @order = Order.new
    unless @service
      redirect_to root_path
    else
      @prestations = @service.categories.first.subcategories
      @produits = @service.categories.last.subcategories
    end
  end

  def add_location_spa
    id = params.permit(:id)
    session[:params_spa].push(id[:id].to_i)
    @index = session[:params_spa].length - 1
    @subcategory = Subcategory.find(id[:id])
    respond_to do |format|
      format.js do

      end
    end
  end

  def del_location_spa
    id = params.permit(:id)
    @subcategory = Subcategory.find(id[:id])
    session[:params_spa].reverse!
    @text_index = session[:params_spa].index(id[:id].to_i)
    if @text_index
      session[:params_spa].delete_at(@text_index)
    end
    session[:params_spa].reverse!
    respond_to do |format|
      format.js do

      end
    end
  end

#===============================================================#
  private

  def is_service(stringvalue="")
    object = false
    case stringvalue
    when 'coiffure-domicile'
      object = Service.find_by(name:'Coiffure')
    when 'estheticienne-domicile'
      object = Service.find_by(name:'Beauté')
    when 'massage-domicile'
      object = Service.find_by(name:'Massage')
    end
    return object
  end
  
  def param_permit
    id = params.permit(:id)
    @category = Category.find(id[:id])
  end
end
