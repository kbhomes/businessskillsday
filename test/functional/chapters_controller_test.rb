require 'test_helper'

class ChaptersControllerTest < ActionController::TestCase
  setup do
    @chapter = chapters(:ironwood)
  end

  test 'should show chapter' do
    get :show, id: @chapter
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @chapter
    assert_response :success
  end

  test 'should update chapter' do
    c = {
      :invoice_sent => true
    }

    put :update, id: @chapter, chapter: c
    assert_redirected_to chapter_path(assigns(:chapter))
  end
end
