ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/reporters'
MiniTest::Reporters.use!

require 'capybara/rails'
require 'mocha/setup'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def login(account, options = {})
    session[:account_id] = account.id
    cookies.permanent[:account_remember_token] = account.remember_token if options.delete(:remember_me)
  end

  def account_for(chapter)
    create :chapter_account, :chapter => chapter
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end