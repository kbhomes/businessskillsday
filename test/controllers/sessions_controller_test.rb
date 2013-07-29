require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @chapter = create :chapter
    @chapter_account = create :chapter_account, :chapter => @chapter, :email => 'chapter@example.com', :password => 'password'
    @staff_account = create :staff_account, :email => 'staff@example.com', :password => 'password'
    @admin_account = create :admin_account, :email => 'admin@example.com', :password => 'password'
  end

  def assert_signed_in(account, options = {})
    assert session[:account_id] == account.id, 'Account ID in session was not set to signed in account'
    assert(cookies[:account_remember_token] == account.remember_token, 'Account remember token was not set in cookies') if options.delete(:remember_me)
  end

  test 'should get login page' do
    get :new
    assert_response :success
  end

  test 'should authenticate chapter account' do
    post :create, :login => { :email => @chapter_account.email, :password => @chapter_account.password }
    assert_signed_in @chapter_account
    assert_redirected_to chapter_url(@chapter)
  end

  test 'should authenticate staff account' do
    post :create, :login => { :email => @staff_account.email, :password => @staff_account.password }
    assert_signed_in @staff_account
    assert_redirected_to admin_url
  end

  test 'should authenticate admin account' do
    post :create, :login => { :email => @admin_account.email, :password => @admin_account.password }
    assert_signed_in @admin_account
    assert_redirected_to admin_url
  end

  test 'should authenticate and remember chapter account' do
    post :create, :login => { :email => @chapter_account.email, :password => @chapter_account.password, :remember_me => "1" }
    assert_signed_in @chapter_account, :remember_me => true
    assert_redirected_to chapter_url(@chapter)
  end

  test 'should authenticate and remember staff account' do
    post :create, :login => { :email => @staff_account.email, :password => @staff_account.password, :remember_me => "1" }
    assert_signed_in @staff_account, :remember_me => true
    assert_redirected_to admin_url
  end

  test 'should authenticate and remember admin account' do
    post :create, :login => { :email => @admin_account.email, :password => @admin_account.password, :remember_me => "1"}
    assert_signed_in @admin_account, :remember_me => true
    assert_redirected_to admin_url
  end

  test 'should logout account' do
    login @chapter_account
    post :destroy
    assert session[:account_id] == nil
    assert_redirected_to login_url
  end
end
