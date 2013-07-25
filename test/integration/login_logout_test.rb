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

  teardown do
    Capybara.reset_sessions!
  end

  test 'login to the site as a chapter' do
    create_chapter_account
    visit login_path
    fill_in 'Email', :with => @account.email
    fill_in 'Password', :with => 'password'
    click_button 'Login'

    # Should redirect to the chapter
    assert current_path == chapter_path(@account.chapter), 'Did not login and redirect user to the chapter'
  end

  test 'login to the site as staff' do
    create_staff_account
    visit login_path
    fill_in 'Email', :with => @account.email
    fill_in 'Password', :with => 'password'
    click_button 'Login'

    # Should redirect to the admin dashboard
    assert current_path == admin_path, 'Did not login and redirect user to the admin dashboard'
  end

  test 'login to the site as an admin' do
    create_admin_account
    visit login_path
    fill_in 'Email', :with => @account.email
    fill_in 'Password', :with => 'password'
    click_button 'Login'

    # Should redirect to the admin dashboard
    assert current_path == admin_path, 'Did not login and redirect user to the admin dashboard'
  end

  test 'failure to login should show an error message' do
    visit login_path
    fill_in 'Email', :with => 'invalid@account.com'
    fill_in 'Password', :with => 'nothing'
    click_button 'Login'

    assert current_path == login_path, 'Did not re-render login page with error'
    assert page.has_content?('Incorrect'), 'Did not show error message when logging in with incorrect information'
  end
end
