class OrdersController < ApplicationController
  # 1/2 Selection des prestation
  def index
    @countries = Country.all
    @departments = Department.all
    @services = Service.all
    # service location spa
    @spas = []
    tmpspa = Spa.all
    tmpspa.each do |spa|
      @spas.push([spa.duration,spa.exceptional_price,spa.ordinary_price,spa.exceptional_acompte,spa.ordinary_acompte])
    end
    # options pour location spa
    @spaoptions = []
    tmpoption = Product.where(is_option_spa:true)
    tmpoption.each do |option|
      @spaoptions.push([option.id,option.name,option.price])
    end
    # service massage
    @massages = []
    #.massage_sus liste sub sub[0].massage_su_prices //differen heurse
    caMassages = MassageCa.all
    # sou massage_ca Name  || massage_su Name ||
    caMassages.each do |ca|
      isCa = [ca.name,[]]
      ca.massage_sus.each do |su|
        isSu = [su.name,[]]
        su.massage_su_prices.each do |price|
          isSu[1].push([price.duration,price.exceptional_price,price.exceptional_acompte,price.ordinary_price,price.ordinary_acompte])
        end
        isCa[1].push(isSu)
      end
      @massages.push(isCa)
    end
    @cadeaus = Product.where(is_option_spa:false)
    # ========================================== #
  end

  # 2/2 Sauvegarder dans une session les données
  def saveSession
    puts "~~~~"*50
    puts params.inspect
    puts "~~~~"*50
  end

  # 2 Selection des adresse de livraison et facturation
  def delivery
    
  end

  # 3 Affiche la recapitulatif de commande
  def summary
    
  end

  # 4 Le Payement
  def payment
    
  end


end





























=begin

JSON.parse("Text to Data") // mamadika ny text ho data 

JSON.stringify(Data) // mamadika ny data ho text


@services = Service.all
# service location spa
@spas = Spa.all
@spaoptions = Product.where(is_option_spa:true)
# service massage
@massages = MassageCa.all #.massage_sus liste sub sub[0].massage_su_prices //differen heurse
@cadeaus = Product.where(is_option_spa:false)


# @categories = @service.categories # Liste de tous les categories

# @products = @service.products # Liste de tous les produits

# @listPrestation = []

# @categories.each do |c|

#   @listPrestation.push([[c.name,c.id]])

#   c.subcategories.each do |s|
#     @listPrestation[@listPrestation.length-1].push([s.id,s.name,s.price])
#   end

# end

# <%= form_tag(saved_commande_path, id:"form", 'data-zones':"#{@listPrestation}", 'data-service':"#{@service.name}") do %>















get 'orders/zone'
  get 'orders/order'

rails g controller Orders zone order
Running via Spring preloader in process 4988
      create  app/controllers/orders_controller.rb
       route  get 'orders/zone'
get 'orders/order'
      invoke  erb
      create    app/views/orders
      create    app/views/orders/zone.html.erb
      create    app/views/orders/order.html.erb
      invoke  test_unit
      create    test/controllers/orders_controller_test.rb
      invoke  helper
      create    app/helpers/orders_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/orders.scss


=end