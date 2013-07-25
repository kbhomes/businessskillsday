class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = ENV['DEVELOPMENT_MAIL_INTERCEPTOR_TO']
  end
end