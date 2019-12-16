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

  test "should get contact" do
    get static_page_contact_url
    assert_response :success
  end

  test "should get galerie" do
    get static_page_galerie_url
    assert_response :success
  end

  test "should get faq" do
    get static_page_faq_url
    assert_response :success
  end

  test "should get cgu" do
    get static_page_cgu_url
    assert_response :success
  end

  test "should get legalnotice" do
    get static_page_legalnotice_url
    assert_response :success
  end

end
