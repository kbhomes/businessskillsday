require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  test 'student must have a grade' do
    s = build :student, :grade => nil
    assert !s.save, 'Saved the student without a grade'
  end

  test 'student\'s grade must be between 9 and 12' do
    s = build :student, :grade => 8
    assert !s.save, 'Saved the student with grade 8'

    (9..12).each do |g|
      s.grade = g
      assert s.save, "Did not save the student with grade #{g}"
    end

    s.grade = 13
    assert !s.save, 'Saved the student with grade 13'
  end

  test 'student must have a name' do
    s = build :student, :name => nil
    assert !s.save, 'Saved the student without a name'
  end

  test 'student must belong to a chapter' do
    s = build :student, :chapter => nil
    assert !s.save, 'Saved the student without a chapter'
  end

  test 'student may not have the same test multiple times' do
    s = create :student
    event = create :written_event

    # Add a new event multiple times.
    s.events << event
    s.events << event

    # The count should have increased by only 1.
    assert_equal 1, s.events.count, 'Added a duplicate event to the student'
  end

  test 'student in grades 11 or 12 may not participate in a 9/10 event' do
    s = create :student, :grade => 11
    event = create :written_event, :nine_ten => true

    # The student should report that it cannot participate in the event.
    assert !s.can_register_for_event?(event), "Grade #{s.grade} student can register for 9/10 event"

    # Add a 9/10 event.
    s.events << event

    # The number of events should still be 0.
    assert_equal 0, s.events.count, "Added a grade #{s.grade} student to a 9/10 event"
  end

  test 'student in grades 9 or 10 may participate in a 9/10 event' do
    s = create :student, :grade => 9
    event = create :written_event, :nine_ten => true

    # The student should report that it can participate in the event.
    assert s.can_register_for_event?(event), "Grade #{s.grade} student cannot register for 9/10 event"

    # Add a 9/10 event.
    s.events << event

    # The number of events should be 1.
    assert_equal 1, s.events.count, "Unable to add a grade #{s.grade} student to a 9/10 event"
  end

  test 'student may not participate in 4 written events' do
    s = create :student

    # Add four written events.
    4.times { s.events << create(:written_event) }

    # The number of events should be 3.
    assert_equal 3, s.events.count, 'Added 4 written events to the student'
  end

  test 'student may not participate in 4 events' do
    s = create :student

    # Add four written events.
    begin
      4.times { s.events << create(:written_event) }
    rescue
    end

    # The number of events should be 3.
    assert_equal 3, s.events.count, 'Added 4 events to the student'
  end

  test 'student may not participate in two performance events' do
    s = create :student

    begin
      s.events << create(:individual_performance_event)
      s.events << create(:individual_performance_event)
    rescue
    end

    # The number of events should be 1.
    assert_equal 1, s.events.count, 'Added 2 performance events to the student'
  end

  test "setting the student's team should add the student to that team's event" do
    event = create :team_performance_event
    t = create :team, :event => event
    s = create :student, :chapter => t.chapter, :team => t

    # Check that there is an MDM event on the student.
    assert s.events.any? { |ev| ev == event }, 'Team event was not added to the student after team was set'
  end

  test "adding a team event to a student should add the student to that team" do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    student = create :student, :chapter => chapter

    # Add the team event to the student.
    student.events << event
    assert student.team == team, 'Student was not added to team for added team event'
  end

  test "removing a team event from a student should remove that student from the team" do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    student = create :student, :chapter => chapter

    # Add the team event to the student.
    student.events << event
    assert student.team == team, 'Student was not added to team for added team event'

    # Remove the team event
    student.events.delete event
    assert student.team == nil, 'Student retained team after removing team event'
  end

  test "adding a team to a student should add them to the event" do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    student = create :student, :chapter => chapter

    # Add the team event to the student.
    student.team = team
    student.save

    assert student.events.first == event, 'Student was not added to team event for added team'
  end

  test "removing a team from the student should remove them from the event" do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    student = create :student, :chapter => chapter

    # Add the team to the student.
    student.team = team
    student.save

    assert student.events.first == event, 'Student was not added to team event for added team'

    # Remove the team from the student.
    student.team = nil
    student.save

    assert student.events.count == 0, 'Student was not removed from team event for removed team'
  end

  test "student cannot register for a team event if they havcheck_maximum_events_limit(r)e no room in their events" do
    s = create :student

    # Add three events.
    s.events << create(:written_event)
    s.events << create(:written_event)
    s.events << create(:individual_performance_event)

    # Add a team event.
    s.team = create(:team, :chapter => s.chapter)
    s.save

    assert s.team == nil && s.events.count == 3, 'Added a team to the student that has no further room for events'
  end

  test 'destroying a student should remove it from any events' do
    chapter = create :chapter
    student = create :student, :chapter => chapter
    events = 3.times.map { create(:written_event) }

    events.each { |ev| student.events << ev }
    assert student.events.count == 3, 'Did not add all events to student'

    student.destroy
    assert events.all? { |ev| ev.students.where{id == student.id}.count == 0 }, 'Did not remove student from all of its events'
  end

  test 'destroying a student should remove it from its team' do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    student = create :student, :chapter => chapter

    student.team = team
    student.save

    assert student.team == team, 'Did not add team to student'
    assert student.events.first == event, 'Did not add team event to student'

    student.destroy
    assert student.team == nil, 'Did not remove student from its team'
    assert student.events.count == 0, 'Did not remove student from its events'
  end
end
