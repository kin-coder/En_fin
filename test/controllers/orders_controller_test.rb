require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get zone" do
    get orders_zone_url
    assert_response :success
  end

  test "should get order" do
    get orders_order_url
    assert_response :success
  end

end
