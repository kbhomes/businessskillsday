require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  setup do
    @chapter = create :chapter
    @team = create :team, :chapter => @chapter
    login account_for(@chapter)
  end

  test 'should get index' do
    get :index, :chapter_id => @chapter
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test 'should get new' do
    get :new, :chapter_id => @chapter
    assert_response :success
  end

  test 'should create team' do
    assert_difference('@chapter.teams.count') do
      post :create,
           :chapter_id => @chapter,
           :team => {
              :event_id => create(:team_performance_event)
           }
    end

    assert_redirected_to chapter_team_path(@chapter, assigns(:team))
  end

  test 'should not create team if one already exists for the event' do
    event = create :team_performance_event
    create :team, :chapter => @chapter, :event => event

    assert_no_difference('@chapter.teams.count') do
      post :create,
           :chapter_id => @chapter.id,
           :team => {
               :event_id => event
           }
    end
  end

  test 'should show team' do
    get :show, :chapter_id => @chapter, id: @team
    assert_response :success
  end

  test 'should get edit' do
    get :edit, :chapter_id => @chapter, id: @team
    assert_response :success
  end

  test 'should update team' do
    put :update,
        :chapter_id => @chapter,
        :id => @team,
        :team => {
            :student_ids => 3.times.map { create :student, :chapter => @chapter }
        }

    assert_redirected_to chapter_team_path(@chapter, assigns(:team))
  end

  test 'should destroy team' do
    assert_difference('@chapter.teams.count', -1) do
      delete :destroy,
             :chapter_id => @chapter,
             :id => @team
    end

    assert_redirected_to chapter_teams_path(@chapter)
  end
end
