require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test 'should redirect index to new' do
    get :index
    assert_redirected_to new_registration_url
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create a registration object' do
    dummy = build :registration

    assert_difference 'Registration.count', 1 do
      post :create, :registration => {
          :chapter  => dummy.chapter,
          :email    => dummy.email,
          :contact  => dummy.contact,
          :address  => dummy.address,
          :city     => dummy.city,
          :state    => dummy.state,
          :zip      => dummy.zip
      }
    end

    assert_response :success
    assert assigns[:registration]
  end

  test 'should not create an invalid registration object, failing with errors' do
    dummy = build :registration

    assert_no_difference 'Registration.count' do
      post :create, :registration => {
          :email    => dummy.email,
          :contact  => dummy.contact,
          :address  => dummy.address,
          :city     => dummy.city,
          :state    => dummy.state,
          :zip      => dummy.zip
      }

    assert !assigns[:registration].errors.empty?
    end
  end

end
