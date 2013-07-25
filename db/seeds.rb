require 'factory_girl'
require 'csv'

# Some major STI problems here; Rails doesn't seem to pick up the
# STI subclasses if their parents aren't picked up first.
require_dependency 'event'
require_dependency 'written_event'
require_dependency 'performance_event'
require_dependency 'individual_performance_event'
require_dependency 'team_performance_event'
require_dependency 'account'
require_dependency 'chapter_account'
require_dependency 'admin_account'
require_dependency 'result'
require_dependency 'student_result'
require_dependency 'team_result'

FAKE = false

if !FAKE
  # Load the events.
  CSV.foreach Rails.root.join('db', 'seeds', 'events.csv'), :headers => true do |row|
    Event.create! row.to_hash
  end

  # Load the chapters.
  CSV.foreach Rails.root.join('db', 'seeds', 'chapters.csv'), :headers => true do |row|
    Chapter.create! row.to_hash
  end

  # Load the advisers.
  CSV.foreach Rails.root.join('db', 'seeds', 'advisers.csv'), :headers => true do |row|
    params = row.to_hash
    chapter = Chapter.find_by_name(params.delete('chapter_name'))
    chapter.advisers.create! params
  end

  # Load the teams.
  CSV.foreach Rails.root.join('db', 'seeds', 'teams.csv'), :headers => true do |row|
    params = row.to_hash
    chapter = Chapter.find_by_name(params.delete('chapter_name'))
    event = Event.find_by_number(params.delete('event_number'))

    chapter.teams.create!(:event_id => event.id)
  end

  # Load the students.
  CSV.foreach Rails.root.join('db', 'seeds', 'students.csv'), :headers => true do |row|
    params = row.to_hash
    chapter = Chapter.find_by_name(params.delete('chapter_name'))
    events = [Event.find_by_number(params.delete('event1')), Event.find_by_number(params.delete('event2')), Event.find_by_number(params.delete('event3'))]

    student = chapter.students.create!(params)
    events.each do |ev|
      if ev
        if ev.is_a? TeamPerformanceEvent
          team = chapter.teams.where(:event_id => ev.id).first
          team.students << student
        end

        student.events << ev
      end
    end
  end

  # Load the results.
  CSV.foreach Rails.root.join('db', 'seeds', 'results.csv'), :headers => true do |row|
    params = row.to_hash
    event = Event.find_by_number(params.delete('event_number'))
    result_class = event.type == 'TeamPerformanceEvent' ? 'TeamResult' : 'StudentResult'

    (1..5).each do |i|
      participant = nil
      name = params.delete("participant#{i}")

      case result_class
        when 'TeamResult'
          chapter = Chapter.find_by_name(name)
          participant = chapter.teams.where{event_id == event.id}.first if chapter
        when 'StudentResult'
          participant = Student.find_by_name(name)
      end

      result_class.constantize.create! :score => (100 - 10*i),
                                       :event => event,
                                       :participant => participant unless participant.blank?
    end
  end

  # Create an admin account, staff account, and an account for each chapter.
  FactoryGirl.create :admin_account, :email => 'admin@example.com', :password => 'password'
  FactoryGirl.create :staff_account, :email => 'staff@example.com', :password => 'password'
  Chapter.find_each { |chapter| FactoryGirl.create :chapter_account, :chapter => chapter, :password => 'password' }
else
  # Create 20 written events, 7 individual performance events, and 4 team performance events.
  written_events    = 20.times.map { FactoryGirl.create :written_event, :nine_ten => [true, false].sample }
  individual_events = 7.times.map  { FactoryGirl.create :individual_performance_event }
  team_events       = 4.times.map  { FactoryGirl.create :team_performance_event }

  # Create 10 different chapters.
  chapters = 10.times.map do |cn|
    chapter = FactoryGirl.create :chapter
    adviser = FactoryGirl.create :adviser, :chapter => chapter

    # Create anywhere between 2 and 4 team events or this chapter.
    teams = rand(2..4).times.map do |tn|
      FactoryGirl.create :team, :chapter => chapter, :event => team_events[tn]
    end

    # Create anywhere between 10 and 30 students for this chapter.
    students = rand(10..30).times.map do |sn|
      student = FactoryGirl.create :student, :chapter => chapter
      num_events = 3

      if student.grade.in?([9,10])
        student.events << written_events.select { |e| e.nine_ten? }.sample
        num_events -= 1
      end

      written_events.reject { |e| e.nine_ten? }.sample(2).each { |e| student.events << e }
      num_events -= 2

      if num_events >= 0
        if [true,false].sample
          # Add an individual performance.
          student.events << individual_events.sample
        else
          # Add a team event.
          t = teams.select { |t| t.can_register_student?(student) }.sample
          student.team = t if t
          student.save
        end
      end
    end

    chapter
  end
end
