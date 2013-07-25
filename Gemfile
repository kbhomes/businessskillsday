source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'thin'

gem 'pg'
gem 'squeel'

group :test do
  if RUBY_PLATFORM =~ /(win32|w32)/
    gem 'win32console', '1.3.0'
  end
  gem 'minitest'
  gem 'minitest-reporters', '>= 0.5.0'
  gem 'ruby-prof'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'capybara'
end

group :development do
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'sextant'

  # To override fixture generation
  gem 'factory_girl_rails'
  gem 'faker'

  gem 'dotenv-rails'
  gem 'aws-sdk'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'sass-rails',   '~> 3.2.3'
gem 'compass-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'introjs-rails'


gem 'strong_parameters'
gem 'bcrypt-ruby', '~> 3.0.1'
gem 'cancan'

gem 'haml'
gem 'haml-rails'

gem 'redcarpet'

gem 'simple_form'
gem 'will_paginate', '~> 3.0'