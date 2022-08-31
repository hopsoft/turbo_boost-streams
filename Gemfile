# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in turbo_ready.gemspec.
gemspec

rails_version = ENV.fetch("RAILS_VERSION", "6.1")

rails_constraint = if rails_version == "main"
  {github: "rails/rails"}
else
  "~> #{rails_version}.0"
end

gem "rails", rails_constraint
gem "sprockets-rails"

gem "pry-byebug"
gem "puma"
gem "rake"

group :test do
  gem "capybara"
  gem "importmap-rails"
  gem "magic_frozen_string_literal"
  gem "net-smtp"
  gem "rexml"
  gem "selenium-webdriver"
  gem "sqlite3"
  gem "standardrb"
  gem "tocer"
  gem "webdrivers"
end
