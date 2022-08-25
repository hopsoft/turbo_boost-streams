# frozen_string_literal: true

require "turbo_ready/version"
require "turbo_ready/railtie"
require "turbo_ready/string"
require "turbo_ready/tag_builder"

module TurboReady
  def self.patch!
    Turbo::Streams::TagBuilder.send :include, TurboReady::TagBuilder
  end
end
