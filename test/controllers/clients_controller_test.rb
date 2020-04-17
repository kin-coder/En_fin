require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get profil" do
    get clients_profil_url
    assert_response :success
  end

  test "should get order" do
    get clients_order_url
    assert_response :success
  end

end
