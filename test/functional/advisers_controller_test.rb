require 'test_helper'

class AdvisersControllerTest < ActionController::TestCase
  setup do
    @adviser = advisers(:dlsmith)
    @chapter = @adviser.chapter
  end

  test "should get index" do
    get :index, :chapter_id => @chapter
    assert_response :success
    assert_not_nil assigns(:advisers)
  end

  test "should get new" do
    get :new, :chapter_id => @chapter
    assert_response :success
  end

  test "should create adviser" do
    assert_difference('@chapter.advisers.count') do
      post :create,
           :chapter_id => @chapter,
           :adviser => {
               :name => 'Renee Ciezki'
           }
    end

    assert_redirected_to chapter_adviser_path(@chapter, assigns(:adviser))
  end

  test "should show adviser" do
    get :show, :chapter_id => @chapter, :id => @adviser
    assert_response :success
  end

  test "should get edit" do
    get :edit, :chapter_id => @chapter, :id => @adviser
    assert_response :success
  end

  test "should update adviser" do
    put :update,
        :chapter_id => @chapter,
        :id => @adviser,
        :adviser => {
          :name => 'David Smith'
        }
    assert_redirected_to chapter_adviser_path(@chapter, assigns(:adviser))
  end

  test "should destroy adviser" do
    assert_difference('@chapter.advisers.count', -1) do
      delete :destroy, :chapter_id => @chapter, :id => @adviser
    end

    assert_redirected_to chapter_advisers_path(@chapter)
  end
end
