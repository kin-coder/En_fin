class OrdersController < ApplicationController
  # 1/2 Selection des prestation
  def zone
    @all_params = params.permit(:country,:department,:date,:heure)
    respond_to do |format|
       format.js
    end 
  end
  
  def code_promo
    parameters = params.permit(:code)
    @code = parameters[:code]
    @test = false
    if CodePromo.all.find_by(code:@code)
      @test = true
      session[:code_promo] = @code
    else
      session.delete(:code_promo)
    end
    respond_to do |format|
       format.js
    end
  end
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
    # orderSpa = [{time:48,type:["a","b"],price:180,option:[["a",12],["c",45]]},{time:48,type:["a","b"],price:180,option:[["a",12],["c",45]]}]
    # orderMassage =  [{ca:"Homme",su:"prénatal",price:[30,120]}]
    orderSpa = []
    params[:timeSpa].each do |k,v|
      tmp = {}
      if Spa.find_by(duration:v[0].to_i)
        tmp["time"] = v[0].to_i
      else
        # erreur
      end
      tmp["type"] = params[:typeSpa][k]
      options = params[:optionSpa][k]

      if options
        tmpOption = []
        options.each do |option|
          product = Product.find_by(name:option)
          if product
            tmpOption.push(option)
          else
            # erreur
          end
        end
        tmp["option"] = tmpOption
      end
      orderSpa.push(tmp)
    end

    puts "~~~"*10
    puts orderSpa
    puts "~~~"*10

    orderMassage = []

    params[:massageSu].each do |k,v|
      tmp = {}
      mCa = MassageCa.find_by(name:v[0])
      if mCa
        tmp["ca"] = v[0]
        mSu = mCa.massage_sus.find_by(name:v[1])
        if mSu
          tmp["su"] = v[1]
        else
          # erreur
        end
      else
        # erreur
      end
      price = MassageSuPrice.find_by(duration:params[:massageSuPrice][k][0].to_i)
      if price
        tmp["price"] = [price.duration,price.ordinary_price,price.ordinary_acompte]
      else
        # erreur
      end
      orderMassage.push(tmp)
    end

    puts "~~~"*10
    puts orderMassage
    puts "~~~"*10


    puts "~~praticien~~"*5
    puts params[:praticien]
    puts "~~~~"*5

    redirect_to delivery_path
  end

  # 2 Selection des adresse de livraison et facturation
  def delivery
    
# email: ""
# first_name: nil, last_name: nil, adresse: nil, tel: nil, sexe: nil>
  @client = Client.first
  @countries = Country.all

  end

  # 3 Affiche la recapitulatif de commande
  def summary
    puts "~~~~"*12
    puts params.inspect
    puts "~~~~"*12
  end

  # 4 Le Payement
  def payment
    
  end


end





























=begin

# massages = params[:massageSu]["3"]
# puts "~~~~"*10
# puts massages[0].split("||")
# puts "~~~~"*10

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
