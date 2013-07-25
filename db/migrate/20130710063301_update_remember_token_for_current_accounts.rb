class UpdateRememberTokenForCurrentAccounts < ActiveRecord::Migration
  def up
    Account.update_all :remember_token => SecureRandom.urlsafe_base64
  end

  def down
    Account.update_all :remember_token => nil
  end
end
