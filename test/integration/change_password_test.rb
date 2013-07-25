require 'test_helper'

class LoginLogoutTest < ActionDispatch::IntegrationTest

  def create_chapter_account
    @account ||= create :chapter_account, :password => 'password'
  end

  def create_staff_account
    @account ||= create :staff_account, :password => 'password'
  end

  def create_admin_account
    @account ||= create :admin_account, :password => 'password'
  end

  def login(account, password = 'password')
    visit login_path
    fill_in 'Email', :with => @account.email
    fill_in 'Password', :with => password
    click_button 'Login'
    assert !page.has_content?('Login'), 'Did not login and redirect account correctly'
  end

  def logout
    click_link 'Logout'
    assert page.has_content?('Login'), 'Did not logout'
  end

  teardown do
    Capybara.reset_sessions!
  end

  test 'successfully change staff password' do
    create_staff_account
    login @account

    visit edit_admin_account_path(@account)

    fill_in 'Current password', :with => 'password'
    fill_in 'New password', :with => 'new_password'
    fill_in 'Password confirmation', :with => 'new_password'
    click_button 'Save Account'

    assert current_path == admin_account_path(@account), 'Did not redirect to account page'
    assert page.has_content?('successfully'), 'Did not change password successfully'

    logout
    login @account, 'new_password'
  end

  test 'error when entering wrong current password' do
    create_staff_account
    login @account

    visit edit_admin_account_path(@account)

    fill_in 'Current password', :with => 'not_password'
    fill_in 'New password', :with => 'new_password'
    fill_in 'Password confirmation', :with => 'new_password'
    click_button 'Save Account'

    assert !page.has_content?('successfully'), 'Did change password successfully'
    assert page.has_content?('is incorrect'), 'Entered current password was correct'
  end

  test 'error when passwords do not match' do
    create_staff_account
    login @account

    visit edit_admin_account_path(@account)

    fill_in 'Current password', :with => 'password'
    fill_in 'New password', :with => 'new_password'
    fill_in 'Password confirmation', :with => 'not_the_same'
    click_button 'Save Account'

    assert !page.has_content?('successfully'), 'Did change password successfully'
    assert page.has_content?('match'), 'Passwords did match'
  end

  test 'error when password is too short' do
    create_staff_account
    login @account

    visit edit_admin_account_path(@account)

    fill_in 'Current password', :with => 'password'
    fill_in 'New password', :with => 'short'
    fill_in 'Password confirmation', :with => 'short'
    click_button 'Save Account'

    assert !page.has_content?('successfully'), 'Did change password successfully'
    assert page.has_content?('minimum'), 'Password was long enough'
  end

  test 'should not require current password to update email' do
    create_staff_account
    login @account

    visit edit_admin_account_path(@account)

    fill_in 'Email', :with => 'not_old_email@example.com'
    click_button 'Save Account'

    assert page.has_content?('successfully'), 'Did not change email successfully'
    assert !page.has_content?('incorrect'), 'Did require current password to be entered and correct'
  end
end
