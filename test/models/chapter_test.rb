require 'test_helper'

class ChapterTest < ActiveSupport::TestCase

  test 'chapter must have a name' do
    assert !build(:chapter, :name => nil).save, 'Saved the chapter without a name'
  end

  test 'chapter must have an address' do
    assert !build(:chapter, :address => nil).save, 'Saved the chapter without an address'
  end

  test 'chapter must have a city' do
    assert !build(:chapter, :city => nil).save, 'Saved the chapter without a city'
  end

  test 'chapter must have a state' do
    assert !build(:chapter, :state => nil).save, 'Saved the chapter without a state'
  end

  test 'chapter must have a valid zip' do
    c = build :chapter, :zip => nil

    assert !c.save, 'Saved the chapter without an zip'

    c.zip = '90ABC'
    assert !c.save, 'Saved the chapter with an invalid zip'

    c.zip = '90210'
    assert c.save, 'Did not save the chapter with a valid zip'
  end

  test 'chapter must have a contact person' do
    assert !build(:chapter, :contact => nil).save, 'Saved the chapter without a contact person'
  end

  test 'chapter must have a valid email' do
    c = build :chapter, :email => nil

    assert !c.save, 'Saved the chapter without an email'

    c.email = 'invalid'
    assert !c.save, 'Saved the chapter with an invalid email'

    c.email = 'valid@email.com'
    assert c.save, 'Did not save the chapter with a valid email'
  end

  test 'chapter must have a unique name' do
    c = create :chapter
    assert !build(:chapter, :name => c.name).save, 'Saved the chapter with an existing name'
  end

  test 'destroying a chapter should destroy all of its teams' do
    chapter = create :chapter
    events = 10.times.map { create :team_performance_event }
    teams = events.map { |ev| create :team, :chapter => chapter, :event => ev }

    assert chapter.teams.count == teams.count, 'Did not add all the teams to the chapter'

    chapter.destroy
    assert teams.none? { |t| Team.exists?(t.id) }, 'Did not destroy all the teams of this chapter'
  end

  test 'destroying a chapter should destroy all of its students' do
    chapter = create :chapter
    students = 10.times.map { create :student, :chapter => chapter }

    assert chapter.students.count == students.count, 'Did not add all the students to the chapter'

    chapter.destroy
    assert students.none? { |s| Student.exists?(s.id) }, 'Did not destroy all the students of this chapter'
  end

  test 'destroying a chapter should destroy all of its advisers' do
    chapter = create :chapter
    advisers = 5.times.map { create :adviser, :chapter => chapter }

    assert chapter.advisers.count == advisers.count, 'Did not add all the advisers to the chapter'

    chapter.destroy
    assert advisers.none? { |a| Adviser.exists?(a.id) }, 'Did not destroy all the advisers of this chapter'
  end

end
