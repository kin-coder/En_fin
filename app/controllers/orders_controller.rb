class OrdersController < ApplicationController
  def zone

  end

  def order

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