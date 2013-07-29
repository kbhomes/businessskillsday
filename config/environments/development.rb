BusinessSkillsDay::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true

  # --------------
  # Mailer options
  # --------------
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address =>         ENV['DEVELOPMENT_SMTP_ADDRESS'],
      :port =>            ENV['DEVELOPMENT_SMTP_PORT'],
      :domain =>          ENV['DEVELOPMENT_SMTP_DOMAIN'],
      :user_name =>       ENV['DEVELOPMENT_SMTP_USERNAME'],
      :password =>        ENV['DEVELOPMENT_SMTP_PASSWORD'],
      :authentication =>  ENV['DEVELOPMENT_SMTP_AUTHENTICATION'],
  }
  config.action_mailer.default_url_options = { :host => ENV['DEVELOPMENT_MAIL_DEFAULT_URL'] }
  ActionMailer::Base.default(:from => ENV['DEVELOPMENT_MAIL_FROM'])
end
