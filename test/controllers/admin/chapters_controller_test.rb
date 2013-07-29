require 'test_helper'

class Admin::ChaptersControllerTest < ActionController::TestCase
  setup do
    @admin_chapter = admin_chapters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_chapters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_chapter" do
    assert_difference('Admin::Chapter.count') do
      post :create, admin_chapter: {  }
    end

    assert_redirected_to admin_chapter_path(assigns(:admin_chapter))
  end

  test "should show admin_chapter" do
    get :show, id: @admin_chapter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_chapter
    assert_response :success
  end

  test "should update admin_chapter" do
    put :update, id: @admin_chapter, admin_chapter: {  }
    assert_redirected_to admin_chapter_path(assigns(:admin_chapter))
  end

  test "should destroy admin_chapter" do
    assert_difference('Admin::Chapter.count', -1) do
      delete :destroy, id: @admin_chapter
    end

    assert_redirected_to admin_chapters_path
  end
end
