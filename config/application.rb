require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Spaced
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults(6.0)

    # NOTE: custom configuration - see https://guides.rubyonrails.org/configuring.html#custom-configuration
    config.x.public_url = URI.parse(ENV.fetch("SPACED_PUBLIC_URL", "http://localhost:3000"))

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.action_mailer.default_options = {
      from: ENV.fetch("SPACED_REPLY_TO_EMAIL", "noreply@example.com"),
      reply_to: ENV.fetch("SPACED_REPLY_TO_EMAIL", "noreply@example.com")
    }

    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address: ENV["SPACED_SMTP_HOST"],
      port: ENV.fetch("SPACED_SMTP_PORT", "587").to_i,
      domain: ENV.fetch("SPACED_SMTP_DOMAIN", nil),
      user_name: ENV["SPACED_SMTP_USERNAME"],
      password: ENV["SPACED_SMTP_PASSWORD"],
      authentication: "plain",
      enable_starttls_auto: true
    }

    config.action_mailer.default_url_options =
      {
        protocol: config.x.public_url.scheme,
        host: config.x.public_url.host,
        port: config.x.public_url.port
      }
  end
end
