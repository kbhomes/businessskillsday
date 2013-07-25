require 'test_helper'

class Admin::ResultsControllerTest < ActionController::TestCase
  setup do
    @admin_result = admin_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_result" do
    assert_difference('Admin::Result.count') do
      post :create, admin_result: {  }
    end

    assert_redirected_to admin_result_path(assigns(:admin_result))
  end

  test "should show admin_result" do
    get :show, id: @admin_result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_result
    assert_response :success
  end

  test "should update admin_result" do
    put :update, id: @admin_result, admin_result: {  }
    assert_redirected_to admin_result_path(assigns(:admin_result))
  end

  test "should destroy admin_result" do
    assert_difference('Admin::Result.count', -1) do
      delete :destroy, id: @admin_result
    end

    assert_redirected_to admin_results_path
  end
end
