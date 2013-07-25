class SessionsController < ApplicationController

  before_filter :can_login, :only => [:new, :create]

  # GET /login
  def new
  end

  # POST /login
  def create
    login = session_params
    email = login[:email]
    password = login[:password]
    remember_me = login[:remember_me] == "1"

    account = Account.find_by_email(email)

    if account.present? && account.authenticate(password)
      login account, :remember_me => remember_me
      post_login_redirect account, 'Successfully logged in.'
    else
      flash.now[:error] = 'Incorrect email or password'
      render :action => :new
    end
  end

  # /logout
  def destroy
    logout
    redirect_to login_url, :notice => 'Successfully logged out.'
  end

  private

    def session_params
      params.require(:login).permit(:email, :password, :remember_me)
    end

    def can_login
      post_login_redirect(current_account) if current_account.present?
    end
end