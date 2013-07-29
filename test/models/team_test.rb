require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  test 'team must have an event' do
    t = build :team, :event => nil
    assert !t.save, 'Saved team without an event'
  end

  test 'team must have a chapter' do
    t = build :team, :chapter => nil
    assert !t.save, 'Saved team without a chapter'
  end

  test "team members must belong to the team's chapter" do
    t = create :team
    c = t.chapter

    # Add a student from the same chapter.
    t.students << create(:student, :chapter => c)

    begin
      # Add a student from a different chapter.
      t.students << create(:student)
    rescue
    end

    # Only the first student student should have been added.
    assert_equal 1, t.students.count, 'Added a student from chapter B to a team from chapter A'
  end

  test 'team may only have 4 members' do
    t = create :team
    c = t.chapter

    begin
      5.times { t.students << create(:student, :chapter => c) }
    rescue
    end

    # Only 4 students should have been added.
    assert_equal 4, t.students.count, 'Added 5 students to the team'
  end

  test 'multiple teams from the same chapter cannot compete in the same event' do
    # Create the event and chapter.
    event = create :team_performance_event
    chapter = create :chapter

    # Create the first team.
    t1 = create :team, :event => event, :chapter => chapter

    # Create the second team.
    t2 = build :team, :event => event, :chapter => chapter

    # The second team should not save properly, given the teams have the same chapters and events.
    assert !t2.save, 'Added a team with the same chapter and team as an existing one'
  end

  test 'adding a student to a team should add the event to the student and set the team of the student' do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    student = create :student, :chapter => chapter

    # Add the student to the team.
    team.students << student

    # Student should have the team event, and the team set.
    assert student.events.first == event, 'Did not add team event to student added to team'
    assert student.team == team, 'Did not set the team of the student to the team it was added to'
  end

  test 'removing a student from a team should remove the event from the student and unset the team of the student' do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    student = create :student, :chapter => chapter

    # Add the student to the team.
    team.students << student

    # Student should have the team event, and the team set.
    assert student.events.first == event, 'Did not add team event to student added to team'
    assert student.team == team, 'Did not set the team of the student to the team it was added to'

    # Remove the student from the team.
    team.students.delete student

    # Student should no longer have the team event, nor the team.
    assert student.events.count == 0, 'Did not remove the team event rom the student removed from team'
    assert student.team == nil, 'Did not unset the team of the student'
  end

  test 'adding a student to a team when it cannot register for that team event should fail' do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    student = create :student, :chapter => chapter

    # Add three written events to the student to fill up its events.
    3.times { student.events << create(:written_event) }
    assert student.events.count == 3

    # Add the student to the team.
    assert !(team.students << student), 'Did add student to team that could not register for team event'
    assert student.events.count == 3, 'Did add team event to student added to team'
    assert student.team == nil, 'Did set the team of the student to the team'
  end

  test 'destroying a team should remove its students from the team' do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    students = 4.times.map do
      s = create :student, :chapter => chapter
      s.team = team
      s.save
      s
    end

    assert team.students.count == 4, 'Did not add all students to the team'

    team.destroy
    students.each do |s|
      s.reload
      assert s.team == nil, 'Did not remove destroyed team from student'
      assert s.events.count == 0, 'Did not remove team event from student'
    end
  end

end