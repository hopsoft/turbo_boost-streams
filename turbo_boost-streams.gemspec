# frozen_string_literal: true

require_relative "lib/turbo_boost/streams/version"

Gem::Specification.new do |s|
  s.name = "turbo_boost-streams"
  s.version = TurboBoost::Streams::VERSION
  s.authors = ["Nate Hopkins (hopsoft)"]
  s.email = ["natehop@gmail.com"]
  s.homepage = "https://github.com/hopsoft/turbo_boost-streams"
  s.summary = "Take full control of the DOM with Turbo Streams"
  s.description = s.summary
  s.license = "MIT"

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = s.homepage
  s.metadata["changelog_uri"] = s.homepage + "/blob/main/CHANGELOG.md"

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "README.md"]

  s.required_ruby_version = ">= 2.7"
  s.add_dependency "rails", ">= 6.1"
  s.add_dependency "turbo-rails", ">= 1.1"

  s.add_development_dependency "capybara"
  s.add_development_dependency "cuprite"
  s.add_development_dependency "foreman"
  s.add_development_dependency "importmap-rails"
  s.add_development_dependency "magic_frozen_string_literal"
  s.add_development_dependency "minitest-reporters"
  s.add_development_dependency "net-smtp"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "puma"
  s.add_development_dependency "rake"
  s.add_development_dependency "rexml"
  s.add_development_dependency "rouge"
  s.add_development_dependency "sprockets-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "standardrb"
  s.add_development_dependency "tailwindcss-rails"
  s.add_development_dependency "web-console"
  s.add_development_dependency "webdrivers"
end
