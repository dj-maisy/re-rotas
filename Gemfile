source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1"
# Use Puma as the app server
gem "puma", "~> 6.0"
# Use SCSS for stylesheets (sass-rails 6 uses sassc, compatible with Ruby 3.x)
gem "sass-rails", "~> 6.0"
# Terser replaces the deprecated uglifier for JavaScript compression
gem "terser"

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.10"

# for SRI
gem "sprockets-rails"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri windows]
  gem "pry"
  # Use sqlite3 as the database for Active Record
  gem "sqlite3", "~> 1.7"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", "~> 3.4"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "rubocop-govuk"
  # webdrivers removed: selenium-webdriver 4+ manages ChromeDriver automatically
  gem "selenium-webdriver", "~> 4.0"
end

group :production do
  gem "pg"
  gem "prometheus-client", "~> 2.1"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Ruby 3.3+ extracted these from stdlib into explicit gems
gem "bigdecimal"
gem "drb"
gem "logger"
gem "minitest", "~> 5.0" # minitest 6.x restructured and removed minitest/mock
gem "mutex_m"
gem "ostruct"

gem "activeadmin"
gem "cf-app-utils"
gem "friendly_id"
gem "http"
gem "icalendar"
gem "redcarpet"
gem "ruby-graphviz"
