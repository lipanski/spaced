# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("SPACED_REPLY_TO_EMAIL", "noreply@example.com")
  layout "mailer"
end
