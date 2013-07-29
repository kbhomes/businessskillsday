require 'test_helper'

class Admin::StudentsControllerTest < ActionController::TestCase
  setup do
    @admin_student = admin_students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_student" do
    assert_difference('Admin::Student.count') do
      post :create, admin_student: {  }
    end

    assert_redirected_to admin_student_path(assigns(:admin_student))
  end

  test "should show admin_student" do
    get :show, id: @admin_student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_student
    assert_response :success
  end

  test "should update admin_student" do
    put :update, id: @admin_student, admin_student: {  }
    assert_redirected_to admin_student_path(assigns(:admin_student))
  end

  test "should destroy admin_student" do
    assert_difference('Admin::Student.count', -1) do
      delete :destroy, id: @admin_student
    end

    assert_redirected_to admin_students_path
  end
end
