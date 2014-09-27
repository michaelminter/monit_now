require 'test_helper'

class ServiceControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
