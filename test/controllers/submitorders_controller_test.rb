require 'test_helper'

class SubmitordersControllerTest < ActionDispatch::IntegrationTest
  test "should get save" do
    get submitorders_save_url
    assert_response :success
  end

end
