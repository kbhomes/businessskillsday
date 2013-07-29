require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  setup do
    @student = create :student
    @chapter = @student.chapter
    login account_for(@chapter)
  end

  test "should get index" do
    get :index, :chapter_id => @chapter
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new, :chapter_id => @chapter
    assert_response :success
  end

  test "should create student" do
    assert_difference('@chapter.students.count') do
      post :create,
           :chapter_id => @chapter,
           :student => {
               :name => 'Michael Bi',
               :grade => 12,
           }
    end

    assert_redirected_to chapter_student_path(@chapter, assigns(:student))
  end

  test "should show student" do
    get :show, :chapter_id => @chapter, :id => @student
    assert_response :success
  end

  test "should get edit" do
    get :edit, :chapter_id => @chapter, :id => @student
    assert_response :success
  end

  test "should update student" do
    put :update,
        :chapter_id => @chapter,
        :id => @student,
        :student => {
            :grade => 9
        }
    assert_redirected_to chapter_student_url(@chapter, @student)
  end

  test "should destroy student" do
    assert_difference('@chapter.students.count', -1) do
      delete :destroy, :chapter_id => @chapter, :id => @student
    end

    assert_redirected_to chapter_students_path
  end

  test 'should add event to student' do
    assert_difference('@student.events.count', 1) do
      put :update,
          :chapter_id => @chapter,
          :id => @student,
          :student => {
              :event_ids => [ create(:written_event) ]
          }
    end

    assert_redirected_to chapter_student_url(@chapter, @student)
  end

  test 'should not add 9/10 event to 11/12 student' do
    @student.grade = 11
    @student.save

    assert_no_difference('@student.events.count') do
      put :update,
          :chapter_id => @chapter,
          :id => @student,
          :student => {
              :event_ids => [ create(:written_event, :nine_ten => true) ]
          }
    end

    assert_template :edit
  end

  test 'should not add performance event to student already with a performance event' do
    assert_no_difference('@student.events.count') do
      put :update,
          :chapter_id => @chapter,
          :id => @student,
          :student => {
              :event_ids => [ create(:individual_performance_event).id, create(:team_performance_event).id ]
          }
    end

    assert_template :edit
  end

  test 'should add 3 written events to student' do
    assert_difference('@student.events.count', 3) do
      put :update,
          :chapter_id => @chapter,
          :id => @student,
          :student => {
              :event_ids => 3.times.map { create(:written_event).id }
          }
    end

    assert_redirected_to chapter_student_url(@chapter, @student)
  end

  test 'should not add 4 written events to student' do
    assert_no_difference('@student.events.count') do
      put :update,
          :chapter_id => @chapter,
          :id => @student,
          :student => {
              :event_ids => 4.times.map { create(:written_event).id }
          }
    end

    assert_template :edit
  end

  test 'should not add 4 events to student' do
    assert_no_difference('@student.events.count') do
      put :update,
          :chapter_id => @chapter,
          :id => @student,
          :student => {
            :event_ids => [
              create(:written_event),
              create(:written_event),
              create(:individual_performance_event),
              create(:team_performance_event)
            ]
          }
    end

    assert_template :edit
  end
end
