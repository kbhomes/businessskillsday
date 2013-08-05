source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'thin'

gem 'pg'
gem 'squeel'
gem 'bcrypt-ruby', '3.0.1'
gem 'cancan'
gem 'dotenv-rails'

gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'haml-rails'
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'redcarpet'
gem 'simple_form', '~> 3.0.0.rc'
gem 'will_paginate', '~> 3.0'

group :test do
  #if RUBY_PLATFORM =~ /(win32|w32)/
  #  gem 'win32console', '1.3.0'
  #end

  gem 'minitest'
  gem 'minitest-reporters', '>= 0.5.0'
  gem 'ruby-prof'
  gem 'capybara'
  gem 'mocha', :require => false
end

group :development do
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'

  gem 'aws-sdk'
end

# Used by Heroku
gem 'rails_12factor', :groups => [:production, :staging]

gem 'factory_girl_rails', :groups => [:development, :test]
gem 'faker',              :groups => [:development, :test]