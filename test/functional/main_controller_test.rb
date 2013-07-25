require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test 'get root route' do
    get :index
    assert_response :success
  end
end
