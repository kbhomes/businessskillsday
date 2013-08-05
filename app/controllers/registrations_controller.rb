class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.valid?
      redirect_to login_url, :notice => 'success'
    else
      render :new
    end
  end

  private

    def registration_params
      params.require(:registration).permit(:chapter, :email, :contact, :address, :city, :state, :zip)
    end
end
