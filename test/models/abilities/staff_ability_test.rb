require 'test_helper'

class StaffAbilityTest < ActiveSupport::TestCase

  setup do
    @account = create :staff_account
    @ability = Ability.new(@account)
  end

  test 'staff account can only read chapter students' do
    chapter = create :chapter
    student = create :student, :chapter => chapter

    assert @ability.can?(:read, student), 'Staff account could not read student'

    assert @ability.cannot?(:create, Student), 'Staff account could create student'
    assert @ability.cannot?(:update, student), 'Staff account could update student'
    assert @ability.cannot?(:destroy, student), 'Staff account could destroy student'
  end

  test 'staff account can only read chapter teams' do
    event = create :team_performance_event
    chapter = create :chapter
    team = create :team, :chapter => chapter, :event => event

    assert @ability.can?(:read, team), 'Staff account could not read team'

    assert @ability.cannot?(:create, Team), 'Staff account could create team'
    assert @ability.cannot?(:update, team), 'Staff account could update team'
    assert @ability.cannot?(:destroy, team), 'Staff account could destroy team'
  end

  test 'staff account can only read advisers' do
    chapter = create :chapter
    adviser = create :adviser, :chapter => chapter

    assert @ability.can?(:read, adviser), 'Staff account could not read adviser'

    assert @ability.cannot?(:create, Adviser), 'Staff account could create adviser'
    assert @ability.cannot?(:update, adviser), 'Staff account could update adviser'
    assert @ability.cannot?(:destroy, adviser), 'Staff account could destroy adviser'
  end

  test 'staff account can only read chapters' do
    chapter = create :chapter

    assert @ability.can?(:read, chapter), 'Staff account could not read chapter'

    assert @ability.cannot?(:create, Chapter), 'Staff account could create chapter'
    assert @ability.cannot?(:update, chapter), 'Staff account could destroy chapter'
    assert @ability.cannot?(:destroy, chapter), 'Staff account could destroy chapter'
  end

  test 'staff account can only read events' do
    written_event = create :written_event
    individual_performance_event = create :individual_performance_event
    team_performance_event = create :team_performance_event

    assert @ability.can?(:read, written_event), 'Staff account could not read written event'
    assert @ability.can?(:read, individual_performance_event), 'Staff account could not read individual event'
    assert @ability.can?(:read, team_performance_event), 'Staff account could not read team performance event'

    assert @ability.cannot?(:create, Event), 'Staff account could create event'
    assert @ability.cannot?(:create, WrittenEvent), 'Staff account could create written event'
    assert @ability.cannot?(:create, PerformanceEvent), 'Staff account could create performance event'
    assert @ability.cannot?(:create, IndividualPerformanceEvent), 'Staff account could create individual performance event'
    assert @ability.cannot?(:create, TeamPerformanceEvent), 'Staff account could create team performance event'
                       
    assert @ability.cannot?(:update, written_event), 'Staff account could update written event'
    assert @ability.cannot?(:update, individual_performance_event), 'Staff account could update individual performance event'
    assert @ability.cannot?(:update, team_performance_event), 'Staff account could update team performance event'
                       
    assert @ability.cannot?(:destroy, written_event), 'Staff account could destroy written event'
    assert @ability.cannot?(:destroy, individual_performance_event), 'Staff account could destroy individual performance event'
    assert @ability.cannot?(:destroy, team_performance_event), 'Staff account could destroy team performance event'
  end

  test 'staff account can only read and edit its own account' do
    assert @ability.can?(:read, @account), 'Staff account could not read its own account'
    assert @ability.can?(:update, @account), 'Staff account could not update its own account'
    assert @ability.cannot?(:destroy, @account), 'Staff account could not delete its own account'

    chapter_account = create :chapter_account
    staff_account = create :staff_account
    admin_account = create :admin_account

    assert @ability.cannot?(:read, chapter_account), 'Staff account could read other chapter account'
    assert @ability.cannot?(:read, staff_account), 'Staff account could read other staff account'
    assert @ability.cannot?(:read, admin_account), 'Staff account could read other admin account'

    assert @ability.cannot?(:create, Account), 'Staff account could create account'
    assert @ability.cannot?(:create, ChapterAccount), 'Staff account could create chapter account'
    assert @ability.cannot?(:create, StaffAccount), 'Staff account could create staff account'
    assert @ability.cannot?(:create, AdminAccount), 'Staff account could create admin account'

    assert @ability.cannot?(:update, chapter_account), 'Staff account could update other chapter account'
    assert @ability.cannot?(:update, staff_account), 'Staff account could update other staff account'
    assert @ability.cannot?(:update, admin_account), 'Staff account could update other admin account'

    assert @ability.cannot?(:destroy, chapter_account), 'Staff account could destroy other chapter account'
    assert @ability.cannot?(:destroy, staff_account), 'Staff account could destroy other staff account'
    assert @ability.cannot?(:destroy, admin_account), 'Staff account could destroy other admin account'
  end

  test 'staff account can access the admin controller' do
    assert @ability.can?(:manage, :admin), 'Staff account could access admin controller'
  end

  test 'staff account cannot manage/create/edit/destroy registrations' do
    registration = create :registration

    assert @ability.cannot?(:manage, Registration), 'Staff account could manage registration'
    assert @ability.cannot?(:create, Registration), 'Staff account could create registration'
    assert @ability.cannot?(:read, registration), 'Staff account could read registration'
    assert @ability.cannot?(:update, registration), 'Staff account could update registration'
    assert @ability.cannot?(:destroy, registration), 'Staff account could destroy registration'
  end
end
