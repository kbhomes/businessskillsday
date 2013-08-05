require 'test_helper'

class RegistrationControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create a registration object' do
    dummy = build :registration

    assert_difference 'Registration.count', 1 do
      post :create, :require => {
          :chapter => dummy.chapter,
          :email => dummy.email,
          :contact => dummy.contact,
          :address => dummy.address,
          :city => dummy.city,
          :state => dummy.state,
          :zip => dummy.zip
      }
    end

    assert_response :success
  end

end
