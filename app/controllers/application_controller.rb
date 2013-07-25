class ApplicationController < ActionController::Base
  # Some major STI problems here; Rails doesn't seem to pick up the
  # STI subclasses if their parents aren't picked up first.
  require_dependency 'event'
  require_dependency 'written_event'
  require_dependency 'performance_event'
  require_dependency 'individual_performance_event'
  require_dependency 'team_performance_event'
  require_dependency 'account'
  require_dependency 'chapter_account'
  require_dependency 'admin_account'
  require_dependency 'result'
  require_dependency 'student_result'
  require_dependency 'team_result'

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |ex|
    if current_account
      redirect_to post_login_url(current_account), :flash => { :error => ex.message}
    else
      redirect_to login_url, :flash => { :error => ex.message }
    end
  end

  def login(account, options = {})
    session[:account_id] = account.id
    cookies.permanent[:account_remember_token] = account.remember_token if options.delete(:remember_me)
  end
  helper_method :login

  def logout
    session[:account_id] = nil
    cookies.delete :account_remember_token
  end
  helper_method :logout

  def current_account
    @current_account ||= Account.find_by_remember_token(cookies[:account_remember_token]) if cookies[:account_remember_token]
    @current_account ||= Account.find(session[:account_id]) if session[:account_id]

    # If this user was retrieved via a remember me cookie, set the account ID in the session.
    session[:account_id] ||= @current_account.id if @current_account

    # Return the current account.
    @current_account
  end
  helper_method :current_account

  def current_ability
    @current_ability ||= Ability.new(current_account)
  end
  helper_method :current_ability

  def post_login_redirect(account, notice = nil)
    redirect_to post_login_url(account), :notice => notice
  end
  helper_method :post_login_redirect

  def post_login_url(account)
    case account
      when ChapterAccount
        chapter_url(account.chapter)
      when StaffAccount, AdminAccount
        admin_url
    end
  end
  helper_method :post_login_url
end
