require 'test_helper'

class Admin::AdvisersControllerTest < ActionController::TestCase
  setup do
    @admin_adviser = admin_advisers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_advisers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_adviser" do
    assert_difference('Admin::Adviser.count') do
      post :create, admin_adviser: {  }
    end

    assert_redirected_to admin_adviser_path(assigns(:admin_adviser))
  end

  test "should show admin_adviser" do
    get :show, id: @admin_adviser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_adviser
    assert_response :success
  end

  test "should update admin_adviser" do
    put :update, id: @admin_adviser, admin_adviser: {  }
    assert_redirected_to admin_adviser_path(assigns(:admin_adviser))
  end

  test "should destroy admin_adviser" do
    assert_difference('Admin::Adviser.count', -1) do
      delete :destroy, id: @admin_adviser
    end

    assert_redirected_to admin_advisers_path
  end
end
