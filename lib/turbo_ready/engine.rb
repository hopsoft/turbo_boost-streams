# frozen_string_literal: true

require "turbo-rails"
require_relative "version"
require_relative "patches"

class TurboReady::Engine < ::Rails::Engine
  config.after_initialize do
    ::Turbo::Streams::TagBuilder.send :include, TurboReady::Patches::TagBuilder
    ::Turbo::Streams::Broadcasts.send :include, TurboReady::Patches::Broadcasts
    ::Turbo::Broadcastable.send :include, TurboReady::Patches::Broadcastable
  end
end
