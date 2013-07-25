
class AccountsController < ApplicationController

  before_filter :redirect_admin, :get_account
  authorize_resource

  def show
  end

  def edit
  end

  def update
    params = account_params
    success = true

    current_password = params.delete(:current_password)
    if params[:password].present? || params[:password_confirmation].present?
      success = @account.authenticate(current_password)
      @account.errors.add(:current_password, 'is incorrect') unless success
    end

    if success && @account.update_attributes(params)
      @current_ability = nil
      @current_user = nil

      redirect_to account_url, notice: 'Account was successfully updated.'
    else
      render action: "edit"
    end
  end

  private

    def redirect_admin
      redirect_to admin_account_url(current_account) if can? :manage, :admin
    end

    def get_account
      @account = current_account
    end

    def account_params
      params.require(:account).permit(:email, :current_password, :password, :password_confirmation)
    end
end