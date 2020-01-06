require 'test_helper'

class PrestatairesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prestataires_index_url
    assert_response :success
  end

  test "should get show" do
    get prestataires_show_url
    assert_response :success
  end

  test "should get new" do
    get prestataires_new_url
    assert_response :success
  end

  test "should get create" do
    get prestataires_create_url
    assert_response :success
  end

  test "should get edit" do
    get prestataires_edit_url
    assert_response :success
  end

  test "should get update" do
    get prestataires_update_url
    assert_response :success
  end

  test "should get destroy" do
    get prestataires_destroy_url
    assert_response :success
  end

end
