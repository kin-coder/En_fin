class OrdersController < ApplicationController
  def zone
    @countries = Country.all
    @departments = Department.all
  end

  def order
    parameters = params.permit(:country, :department)
    if parameters[:country] == "" || (parameters[:country] == "France" && parameters[:department] == "")
      redirect_back(fallback_location: root_path)
    end

    @services = Service.all

    # service location spa
    @spas = Spa.all
    @spaoptions = Product.where(is_option_spa:true)

    # service massage
    @massages = MassageCa.all #.massage_sus liste sub sub[0].massage_su_prices //differen heurse
    @cadeaus = Product.where(is_option_spa:false)
 
    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_path)
      end
      format.js do

      end
    end

  end
end

=begin

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