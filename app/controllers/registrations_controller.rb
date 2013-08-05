class RegistrationsController < ApplicationController

  before_filter :redirect_accounts

  def index
    redirect_to new_registration_url
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      render :done
    else
      render :new
    end
  end

  private

    def redirect_accounts
      redirect_to post_login_url(current_account), :flash => { :error => 'You cannot register for another account.' } unless can?(:create, Registration)
    end

    def registration_params
      params.require(:registration).permit(:chapter, :email, :contact, :address, :city, :state, :zip)
    end
end
