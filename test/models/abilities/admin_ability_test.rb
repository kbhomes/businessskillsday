require 'test_helper'

class AdminAbilityTest < ActiveSupport::TestCase

  setup do
    @account = create :admin_account
    @ability = Ability.new(@account)
  end

  test 'admin account can manage all' do
    assert @ability.can?(:manage, :all), 'Admin account could not manage all'
  end

  test 'admin account can access admin controller' do
    assert @ability.can?(:manage, :admin), 'Admin account could not access admin controller'
  end

  test 'admin account can create/edit/destroy students' do
    chapter = create :chapter
    student = create :student, :chapter => chapter

    assert @ability.can?(:create, Student), 'Admin account could not create student'
    assert @ability.can?(:update, student), 'Admin account could not update student'
    assert @ability.can?(:destroy, student), 'Admin account could not destroy student'
  end

  test 'admin account can create/edit/destroy teams' do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event

    assert @ability.can?(:create, Team), 'Admin account could not create team'
    assert @ability.can?(:update, team), 'Admin account could not update team'
    assert @ability.can?(:destroy, team), 'Admin account could not destroy team'
  end

  test 'admin account can create/edit/destroy advisers' do
    chapter = create :chapter
    adviser = create :adviser, :chapter => chapter

    assert @ability.can?(:create, Adviser), 'Admin account could not create adviser'
    assert @ability.can?(:update, adviser), 'Admin account could not update adviser'
    assert @ability.can?(:destroy, adviser), 'Admin account could not destroy adviser'
  end

  test 'admin account can create/edit/destroy chapters' do
    chapter = create :chapter

    assert @ability.can?(:create, Chapter), 'Admin account could not create chapter'
    assert @ability.can?(:update, chapter), 'Admin account could not destroy chapter'
    assert @ability.can?(:destroy, chapter), 'Admin account could not destroy chapter'
  end

  test 'admin account can create/edit/destroy events' do
    written_event = create :written_event
    individual_performance_event = create :individual_performance_event
    team_performance_event = create :team_performance_event

    assert @ability.can?(:create, Event), 'Admin account could not create event'
    assert @ability.can?(:create, WrittenEvent), 'Admin account could not create written event'
    assert @ability.can?(:create, PerformanceEvent), 'Admin account could not create performance event'
    assert @ability.can?(:create, IndividualPerformanceEvent), 'Admin account could not create individual performance event'
    assert @ability.can?(:create, TeamPerformanceEvent), 'Admin account could not create team performance event'

    assert @ability.can?(:update, written_event), 'Admin account could not update written event'
    assert @ability.can?(:update, individual_performance_event), 'Admin account could not update individual performance event'
    assert @ability.can?(:update, team_performance_event), 'Admin account could not update team performance event'

    assert @ability.can?(:destroy, written_event), 'Admin account could not destroy written event'
    assert @ability.can?(:destroy, individual_performance_event), 'Admin account could not destroy individual performance event'
    assert @ability.can?(:destroy, team_performance_event), 'Admin account could not destroy team performance event'
  end

  test 'admin account can create/edit/destroy accounts' do
    chapter_account = create :chapter_account
    admin_account = create :admin_account

    assert @ability.can?(:create, Account), 'Admin account could not create account'
    assert @ability.can?(:create, ChapterAccount), 'Admin account could not create chapter account'
    assert @ability.can?(:create, AdminAccount), 'Admin account could not create admin account'

    assert @ability.can?(:update, chapter_account), 'Admin account could not update other chapter account'
    assert @ability.can?(:update, admin_account), 'Admin account could not update other admin account'

    assert @ability.can?(:destroy, chapter_account), 'Admin account could not destroy other chapter account'
    assert @ability.can?(:destroy, admin_account), 'Admin account could not destroy other admin account'
  end
end
