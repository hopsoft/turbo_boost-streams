# frozen_string_literal: true

require_relative "lib/turbo_ready/version"

Gem::Specification.new do |s|
  s.name = "turbo_ready"
  s.version = TurboReady::VERSION
  s.authors = ["Nate Hopkins (hopsoft)"]
  s.email = ["natehop@gmail.com"]
  s.homepage = "https://github.com/hopsoft/turbo_ready"
  s.summary = "Take full control of the DOM with Turbo Streams"
  s.description = s.summary
  s.license = "MIT"

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = s.homepage
  s.metadata["changelog_uri"] = s.homepage + "/blob/master/CHANGELOG.md"

  s.files = Dir["lib/**/*.rb", "app/**/*", "bin/*", "[A-Z]*"]

  s.add_dependency "rails", ">= 6.1"
  s.add_dependency "turbo-rails", ">= 1.1"
end
