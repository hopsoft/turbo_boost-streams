# frozen_string_literal: true

require_relative "lib/turbo_ready/version"

Gem::Specification.new do |spec|
  spec.name = "turbo_ready"
  spec.version = TurboReady::VERSION
  spec.authors = ["Nate Hopkins (hopsoft)"]
  spec.email = ["natehop@gmail.com"]
  spec.homepage = "https://github.com/hopsoft/turbo_ready"
  spec.summary = "Take full control of the DOM with Turbo Streams"
  spec.description = spec.summary
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/blob/master/CHANGELOG.md"

  spec.files = Dir["lib/**/*.rb", "app/**/*", "bin/*", "[A-Z]*"]

  spec.add_dependency "rails", ">= 6.1"
  spec.add_dependency "turbo-rails", ">= 1.1"

  spec.add_development_dependency "magic_frozen_string_literal"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "standardrb"
  spec.add_development_dependency "tocer"
end
