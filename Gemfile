# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.7.1"

# Core
gem "rails", "~> 6.1.3"
gem "bootsnap", ">= 1.4.2", require: false
gem "devise"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search"
gem "puma", "~> 4.3"
gem "rack-timeout" # NOTE: timeout requests (puma doesn't)
gem "redis"
gem "hiredis"

# API
gem "graphql"

# Frontend
gem "minipack" # NOTE: use a vanilla webpack config
gem "turbo-rails"
gem "draper"
gem "pagy" # NOTE: fast pagination
gem "simple_form" # NOTE: keeps forms very DRY

# Optimizations
gem "goldiloader" # NOTE: automatic eager loading
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
  gem "letter_opener"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "sql_spy"
end
