require 'test_helper'

class AdminTasksControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

end
