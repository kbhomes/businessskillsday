require 'test_helper'

class ResultTest < ActiveSupport::TestCase

  test 'result must have a score' do
    result = build :student_result, :score => nil
    assert !result.save, 'Did save result without a score'
  end

  test 'result must have an event' do
    result = build :student_result
    assert result.save, 'Did not save result with an event'

    result.event = nil
    assert !result.save, 'Did save result without an event'
  end

  test 'result must have a participant' do
    result = build :student_result
    assert result.save, 'Did not save result with a participant'

    result.participant = nil
    assert !result.save, 'Did save result without a participant'
  end

  test 'student results are visible on the student' do
    student = create :student
    events = 3.times.map { create :written_event }

    events.each { |ev| student.events << ev }
    events.each { |ev| create :student_result, :participant => student, :event => ev }

    assert student.results.count == 3, 'Did not give 3 results to student'
  end

  test 'results should be ordered by score' do
    event = create :written_event
    10.times { create :student_result, :event => event }

    event.results.inject 101 do |prev, result|
      assert prev >= result.score, 'Previous score was not greater/equal to current score'
      result.score
    end
  end

  test 'top five results should be correct' do
    event = create :written_event
    10.times { create :student_result, :event => event }

    ordered = event.results
    top_five = event.results.top_five

    top_five.each_with_index do |result, i|
      assert ordered[i] == result, "#{i.ordinalize} ranked result did not match"
    end
  end

  test 'top five results should have correct rank' do
    event = create :written_event
    10.times { create :student_result, :event => event }

    event.results.top_five.each_with_index do |result, i|
      assert result.rank == (i + 1), 'Rank of top five result did not match its index'
    end
  end

  test 'non top-five result should not have ranks' do
    event = create :written_event
    10.times { create :student_result, :event => event }

    event.results.offset(5).each_with_index do |result, i|
      assert result.rank.blank?, "Result at index #{i} (greater than 5) did have rank"
    end
  end

end
