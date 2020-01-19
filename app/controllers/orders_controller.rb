class OrdersController < ApplicationController
  before_action :param_permit, only: [:index_addcategory, :index_delcategory]
  def index
    params.permit(:name)
    @service = is_service(params[:name]) # un objet de type service
    unless @service
      redirect_to root_path
    else
      @categories = @service.categories # Liste de tous les categories
      @listPrestation = []
      @categories.each do |c|
        @listPrestation.push([[c.name,c.id]])
        c.subcategories.each do |s|
          @listPrestation[@listPrestation.length-1].push([s.id,s.name,s.price])
        end
      end
    end
  end

  def index_addcategory
    @subcategories = @category.subcategories
    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do
      end
    end
  end

  def index_delcategory
    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do

      end
    end
  end

  def index_subcategory
    parameters = params.permit(:category,:subcategory,:index)
    @category = Category.find(parameters[:category].to_i)
    @subcategory = Subcategory.find(parameters[:subcategory].to_i)
    @index = parameters[:index].to_i
    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do
      end
    end

  end

#==================== Tunel d'achat location spa ===============#
  def spa_reservation
    @service = Service.find_by(name:'Location spa')
    @subcategories = @service.categories[0].subcategories

  end

  def spa_addsubcategory
    
  end

  def spa_delsubcategory
    
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
