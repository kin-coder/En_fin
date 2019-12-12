require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get static_page_index_url
    assert_response :success
  end

  test "should get massage" do
    get static_page_massage_url
    assert_response :success
  end

  test "should get spa" do
    get static_page_spa_url
    assert_response :success
  end

end
