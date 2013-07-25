class UpdateRememberTokenForEachAccount < ActiveRecord::Migration
  def up
    # Major bug, last migration applied the same remember_me token to each account.
    # Whoops.
    Account.all.each { |a| a.update_attributes :remember_token => SecureRandom.urlsafe_base64 }
  end

  def down
    Account.update_all :remember_token => false
  end
end
