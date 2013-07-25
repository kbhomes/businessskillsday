require 'test_helper'

class ChapterAbilityTest < ActiveSupport::TestCase

  test 'chapter account can read/create/edit/destroy only its own students' do
    chapter = create :chapter
    student = create :student, :chapter => chapter
    account = create :chapter_account, :chapter => chapter
    ability = Ability.new(account)

    assert ability.can?(:read, student), 'Chapter account could not read student'
    assert ability.can?(:create, Student), 'Chapter account could not create student'
    assert ability.can?(:update, student), 'Chapter account could not update student'
    assert ability.can?(:destroy, student), 'Chapter account could not destroy student'

    other_student = create :student # Creates a new chapter for it.
    assert ability.cannot?(:read, other_student), 'Chapter account could read student of other chapter'
    assert ability.cannot?(:update, other_student), 'Chapter account could update student of other chapter'
    assert ability.cannot?(:destroy, other_student), 'Chapter account could destroy student of other chapter'
  end

  test 'chapter account can read/create/edit/destroy only its own teams' do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event
    account = create :chapter_account, :chapter => chapter
    ability = Ability.new(account)

    assert ability.can?(:read, team), 'Chapter account could not read team'
    assert ability.can?(:create, Team), 'Chapter account could not create team'
    assert ability.can?(:update, team), 'Chapter account could not update team'
    assert ability.can?(:destroy, team), 'Chapter account could not destroy team'

    other_team = create :team, :event => event # Creates a new chapter for it.
    assert ability.cannot?(:read, other_team), 'Chapter account could read team of other chapter'
    assert ability.cannot?(:update, other_team), 'Chapter account could update team of other chapter'
    assert ability.cannot?(:destroy, other_team), 'Chapter account could destroy team of other chapter'
  end

  test 'chapter account can read/create/edit/destroy only its own advisers' do
    chapter = create :chapter
    adviser = create :adviser, :chapter => chapter
    account = create :chapter_account, :chapter => chapter
    ability = Ability.new(account)

    assert ability.can?(:read, adviser), 'Chapter account could not read adviser'
    assert ability.can?(:create, Adviser), 'Chapter account could not create adviser'
    assert ability.can?(:update, adviser), 'Chapter account could not update adviser'
    assert ability.can?(:destroy, adviser), 'Chapter account could not destroy adviser'

    other_adviser = create :adviser # Creates a new chapter for it.
    assert ability.cannot?(:read, other_adviser), 'Chapter account could read adviser of other chapter'
    assert ability.cannot?(:update, other_adviser), 'Chapter account could update adviser of other chapter'
    assert ability.cannot?(:destroy, other_adviser), 'Chapter account could destroy adviser of other chapter'
  end

  test 'chapter account cannot create or destroy chapters' do
    chapter = create :chapter
    account = create :chapter_account, :chapter => chapter
    ability = Ability.new(account)

    other_chapter = create :chapter

    assert ability.cannot?(:create, Chapter), 'Chapter account could create a new chapter'
    assert ability.cannot?(:destroy, chapter), 'Chapter account could destroy its own chapter'
    assert ability.cannot?(:destroy, other_chapter), 'Chapter account could destroy another chapter'
  end

  test 'chapter account can read/edit its own chapter' do
    chapter = create :chapter
    account = create :chapter_account, :chapter => chapter
    ability = Ability.new(account)

    assert ability.can?(:read, chapter), 'Chapter account could not read its own chapter'
    assert ability.can?(:update, chapter), 'Chapter account could not update its own chapter'

    other_chapter = create :chapter
    assert ability.cannot?(:read, other_chapter), 'Chapter account could read another chapter'
    assert ability.cannot?(:update, other_chapter), 'Chapter account could update another chapter'
  end

  test 'chapter account cannot access the admin controller' do
    account = create :chapter_account
    ability = Ability.new(account)

    assert ability.cannot?(:manage, :admin), 'Chapter account could access admin controller'
  end

  test 'chapter account can read/edit its own account' do
    chapter = create :chapter
    account = create :chapter_account, :chapter => chapter
    ability = Ability.new(account)

    assert ability.can?(:read, account), 'Chapter account could not read its own account'
    assert ability.can?(:update, account), 'Chapter account could not update its own account'

    assert ability.cannot?(:create, Account), 'Chapter account could create a new account'
    assert ability.cannot?(:destroy, account), 'Chapter account could destroy its own account'

    other_account = create :chapter_account
    assert ability.cannot?(:read, other_account), 'Chapter account could read other account'
    assert ability.cannot?(:update, other_account), 'Chapter account could update other account'
    assert ability.cannot?(:destroy, other_account), 'Chapter account could destroy other account'
  end

end
