require 'test_helper'

class AboutControllerTest < ActionController::TestCase
  test "should get get:help" do
    get :get:help
    assert_response :success
  end

end
