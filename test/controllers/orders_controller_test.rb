require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orders_index_url
    assert_response :success
  end

  test "should get addcategory" do
    get orders_addcategory_url
    assert_response :success
  end

  test "should get delcategory" do
    get orders_delcategory_url
    assert_response :success
  end

  test "should get subcategory" do
    get orders_subcategory_url
    assert_response :success
  end

end
