require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test 'account must have a valid email' do
    assert !build(:chapter_account, :email => nil).save, 'Created account without an email address'
    assert !build(:chapter_account, :email => 'test').save, 'Created account without a valid email address'
    assert create(:chapter_account), 'Did not create account with a valid email address'
  end

  test 'chapter account must have a chapter' do
    assert !build(:chapter_account, :chapter => nil).save, 'Created chapter account without a chapter'
    assert create(:chapter_account), 'Did not create chapter account with a chapter'
  end

  test 'chapter account can manage its own chapter' do
    chapter = create :chapter
    account = create :chapter_account, :chapter => chapter
    ability = Ability.new(account)

    assert ability.can?(:read, chapter), 'Chapter account cannot read its own chapter'
    assert ability.can?(:update, chapter), 'Chapter account cannot update its own chapter'
    assert ability.can?(:results, chapter), 'Chapter account cannot manage results on its own chapter'
  end

  test 'chapter account cannot manage another chapter' do
    other = create :chapter
    account = create :chapter_account
    ability = Ability.new(account)

    assert ability.cannot?(:manage, other), 'Chapter account can manage another chapter'
  end

  test 'admin account can manage any chapter' do
    chapter = create :chapter
    account = create :admin_account
    ability = Ability.new(account)

    assert ability.can?(:manage, chapter), 'Admin account cannot manage chapter'
  end

end
