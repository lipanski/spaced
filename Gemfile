# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.5.3"

gem "rails", "~> 6.0.2", ">= 6.0.2.1"

gem "bootsnap", ">= 1.4.2", require: false
gem "devise"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"

gem "draper"
gem "haml-rails"
gem "pagy"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "simple_form"

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "database_consistency", require: false
  gem "annotate"
  gem "rubocop"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end
