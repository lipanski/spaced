# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.7.1"

gem "rails", "~> 6.1.3"

gem "webpacker"
gem "bootsnap", ">= 1.4.2", require: false
gem "devise"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search"
gem "puma", "~> 4.3"
gem "rack-timeout" # NOTE: timeout requests (puma doesn't)

gem "goldiloader" # NOTE: automatic eager loading

# API
gem "graphql"

gem "draper"
gem "hamlit" # NOTE: fast haml implementation
gem "pagy" # NOTE: fast pagination
gem "turbolinks", "~> 5"
gem "simple_form" # NOTE: keeps forms very DRY

gem "strong_migrations" # NOTE: prevent unsafe migrations

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "rubocop" # NOTE: use a common style (but nothing too intrusive)
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "annotate" # NOTE: annotates models with schema information
  gem "database_consistency", require: false # NOTE: checks for model validation consistency
  gem "foreman"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "sql_spy"
end
