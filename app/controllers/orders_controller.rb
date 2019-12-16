class OrdersController < ApplicationController
  include OrdersHelper
  def index
    params.permit(:name)
    @service = is_service(params[:name]) # un objet de type service
    unless @service
      redirect_to root_path
    else
      @categories = @service.categories # Liste de tous les categories
      if session[:service] == nil || session[:service] != @service.name
        session[:service] = @service.name
        session[:prestation] = []
      end
      @paniers = session[:prestation]
    end
  end

  def addcategory
    @category = param_permit
    session[:prestation].push({"category"=>[@category.name,@category.id]})
    @arrayid = session[:prestation].length - 1
    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do
      end
    end
  end

  def delcategory
    @category = param_permit
    session[:prestation].reverse_each do |presta|
      if presta.value?([@category.name,@category.id])
        key = session[:prestation].index(presta)
        session[:prestation].delete_at(key)
        break
      end
    end
    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do

      end
    end
  end

  def subcategory
    parametre = params.permit(:name,:key,:subcategory)
    # :key index du tableau session[:prestation]
    @arrayid = parametre[:key].to_i
    @subc = Subcategory.find(parametre[:subcategory].to_i)
    # @category utiliser dans le fichier subcategory.js
    @category = session[:prestation][@arrayid.to_i]["category"]
    if parametre[:name]
      if session[:prestation][@arrayid]["subcategory"] == nil
        session[:prestation][@arrayid]["subcategory"] = [[@subc.id,@subc.name]]
      else
        session[:prestation][@arrayid]["subcategory"].push([@subc.id,@subc.name])
      end
    else
      session[:prestation][@arrayid]["subcategory"].delete([@subc.id,@subc.name])
    end

    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do

      end
    end
  end

  private

  def is_service(stringvalue="")
    object = false
    case stringvalue
    when 'coiffure-domicile'
      object = Service.where(name:'Coiffure')[0]
    when 'estheticienne-domicile'
      object = Service.where(name:'Beauté')[0]
    when 'massage-domicile'
      object = Service.where(name:'Massage')[0]
    when 'location-spa'
    object = Service.where(name:'Location spa')[0]
  end
  return object
  end
  
  def param_permit
    id = params.permit(:id)
    ca = Category.find(id[:id])
  end
end
