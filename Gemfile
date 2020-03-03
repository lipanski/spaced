# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.5.3"

gem "rails", "~> 6.0.2", ">= 6.0.2.1"

gem "bootsnap", ">= 1.4.2", require: false
gem "devise"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search"
gem "puma", "~> 4.3"

gem "draper"
gem "hamlit" # NOTE: fast haml implementation
gem "pagy" # NOTE: fast pagination
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "simple_form" # NOTE: keeps forms very DRY

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

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
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end
