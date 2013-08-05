require 'test_helper'

class NoAbilityTest < ActiveSupport::TestCase

  setup do
    @ability = Ability.new nil
  end

  test 'guest account can create registration' do
    assert @ability.can?(:create, Registration), 'Guest account could not create registration'
  end

  test 'guest account cannot manage/read/update/destroy/approve registration' do
    registration = create :registration

    assert @ability.cannot?(:manage, Registration), 'Guest account could manage registration'
    assert @ability.cannot?(:read, registration), 'Guest account could read registration'
    assert @ability.cannot?(:update, registration), 'Guest account could update registration'
    assert @ability.cannot?(:destroy, registration), 'Guest account could destroy registration'
    assert @ability.cannot?(:approve, registration), 'Guest account could approve registration'
  end
end
