require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test 'event must have a unique number' do
    e = build :written_event, :number => nil
    assert !e.save, 'Saved the event without a number'

    e.number = create(:written_event).number
    assert !e.save, 'Saved the event with a non-unique number'

    e = build :written_event
    assert e.save, 'Did not save the event with a unique number'
  end

  test 'event must have a unique name' do
    e = build :written_event, :name => nil
    assert !e.save, 'Saved the event without a name'

    e.name = create(:written_event).name
    assert !e.save, 'Saved the event with a non-unique name'

    e = build :written_event
    assert e.save, 'Did not save the event with a unique name'
  end

  test 'deleting an event removes the event from the students' do
    event = create :written_event
    chapter = create :chapter
    students = 10.times.map { create :student, :chapter => chapter }

    # Add the event to each student.
    students.each { |s| s.events << event }
    assert event.participants.count == students.count, 'Did not add the students to the event'
    assert students.all? { |s| s.events.first == event }, 'Did not add the event to each student'

    # Destroy the event.
    event.destroy
    assert students.all? { |s| s.events.count == 0 }, 'Did not remove the event from the students upon destruction'
  end

  test 'deleting a team event destroys the teams' do
    event = create :team_performance_event
    teams = 10.times.map do
      chapter = create :chapter
      team = create :team, :chapter => chapter, :event => event
      students = 10.times.map do
        s = create :student, :chapter => chapter
        s.team = team
        s.save
      end
      team
    end

    # Add the event to each student.
    assert event.participants.count == teams.count, 'Did not add the teams to the event'
    assert teams.all? { |t| t.event == event }, 'Did not add the event to each team'

    # Destroy the event.
    event.destroy
    assert teams.all? { |t| !Team.exists?(t) }, 'Did not destroy each team'
  end

end
