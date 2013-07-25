class AccountMailer < ActionMailer::Base

  def new_account(account, password)
    @account = account
    @password = password

    mail :to => account.email, :subject => 'BSD 25 - Account Registered'
  end

end
