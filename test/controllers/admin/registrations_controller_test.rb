require 'test_helper'

class Admin::RegistrationsControllerTest < ActionController::TestCase

  setup do
    login create(:admin_account)
  end

  test 'should show a list of all pending registrations' do
    get :index
    assert_response :success
    assert assigns(:registrations), 'Registrations were not available to the page'
  end

  test 'should show a registration' do
    registration = create :registration
    get :show, :id => registration.id

    assert_response :success
    assert assigns(:registration).present?, 'Registration was not available to the page'
    assert assigns(:registration).id == registration.id, 'Retrieved incorrect registration'
  end

  test 'should get the edit page of a registration' do
    registration = create :registration

    get :edit, :id => registration.id

    assert_response :success
    assert assigns(:registration).present?, 'Registration was not available to the page'
    assert assigns(:registration).id == registration.id, 'Retrieved incorrect registration'
  end

  test 'should update a registration' do
    registration = create :registration

    patch :update, :id => registration.id, :registration => { :chapter  => 'Chapter Name That Is Highly Unlikely To Be Taken' }

    assert_redirected_to admin_registration_url(registration), 'Did not successfully update registration and redirect'
    assert assigns(:registration).present?, 'Registration was not available to the page'
    assert assigns(:registration).id == registration.id, 'Retrieved incorrect registration'
  end

  test 'should get the delete page for a registration' do
    registration = create :registration

    assert_no_difference 'Registration.count' do
      get :delete, :id => registration.id
    end

    assert_response :success
    assert_template :delete
  end

  test 'should destroy a registration' do
    registration = create :registration

    assert_difference 'Registration.count', -1 do
      delete :destroy, :id => registration.id
    end

    assert_redirected_to admin_registrations_url, 'Did not successfully delete registration and redirect'
  end

  test 'should show the confirm page showing what will happen to the registration' do
    registration = create :registration
    get :confirm, :id => registration.id

    assert_response :success
    assert_template :confirm
  end

  test 'should approve a registration into a corresponding chapter and account' do
    registration = create :registration
    count = Registration.count

    assert_difference ['Chapter.count', 'Account.count'] do
      post :approve, :id => registration.id
    end

    assert_redirected_to admin_account_url(Account.where{email == registration.email}.first), 'Did not redirect to a chapter account'

    assert_equal (count - Registration.count), 1, 'Did not delete approved registration'
    assert Chapter.where{name == registration.chapter}.exists?, 'Did not create a corresponding chapter'
    assert Account.where{email == registration.email}.exists?, 'Did not create a corresponding account'

    assert !ActionMailer::Base.deliveries.empty?, 'Did not send any emails'
    assert ActionMailer::Base.deliveries.last.to.include?(registration.email), 'Did not send account details to email'
  end

end
