# frozen_string_literal: true

require "turbo-rails"
require_relative "version"
require_relative "patches"

class TurboBoost::Engine < ::Rails::Engine
  config.after_initialize do
    ::Turbo::Streams::TagBuilder.send :include, TurboBoost::Streams::Patches::TagBuilder
    ::Turbo::Streams::Broadcasts.send :include, TurboBoost::Streams::Patches::Broadcasts
    ::Turbo::Broadcastable.send :include, TurboBoost::Streams::Patches::Broadcastable
  end
end
