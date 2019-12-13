class OrdersController < ApplicationController
  def index
  	params.permit(:name)
  	@service = is_service(params[:name]) # un objet de type service
  	unless @service
  		redirect_to root_path
  	else
  		# Liste de tous les categories
	  	@categories = @service.categories
	  	# Création d'une nouvelle session
	  	if session[:service] == nil || session[:service] != @service.name
	  		session[:service] = @service.name
	  		session[:prestation] = []
	  	end
	  	# Liste des produit dans le panier
	  	@paniers = session[:prestation]
  	end
  end

  def addcategory
  end

  def delcategory
  end

  def subcategory
  end

  private

  def is_service(name="")
  	object = nil
  	case name
	  when 'massage-domicile'
	  	object = Service.find_by(name:"Massage")
	  when 'location-spa'
		object = Service.find_by(name:'Location spa')
	end
	return object
  end

end

=begin

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
=end