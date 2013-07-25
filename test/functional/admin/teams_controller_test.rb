require 'test_helper'

class Admin::TeamsControllerTest < ActionController::TestCase
  setup do
    @admin_team = admin_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_team" do
    assert_difference('Admin::Team.count') do
      post :create, admin_team: {  }
    end

    assert_redirected_to admin_team_path(assigns(:admin_team))
  end

  test "should show admin_team" do
    get :show, id: @admin_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_team
    assert_response :success
  end

  test "should update admin_team" do
    put :update, id: @admin_team, admin_team: {  }
    assert_redirected_to admin_team_path(assigns(:admin_team))
  end

  test "should destroy admin_team" do
    assert_difference('Admin::Team.count', -1) do
      delete :destroy, id: @admin_team
    end

    assert_redirected_to admin_teams_path
  end
end
