# frozen_string_literal: true

require "turbo-rails"
require_relative "version"
require_relative "patches"

class TurboBoost::Engine < ::Rails::Engine
  config.turbo_boost_streams = ActiveSupport::OrderedOptions.new
  config.turbo_boost_streams.precompile_assets = true

  config.after_initialize do
    ::Turbo::Streams::TagBuilder.send :include, TurboBoost::Streams::Patches::TagBuilder
    ::Turbo::Streams::Broadcasts.send :include, TurboBoost::Streams::Patches::Broadcasts
    ::Turbo::Broadcastable.send :include, TurboBoost::Streams::Patches::Broadcastable
  end

  initializer "turbo_boost_streams.asset" do
    config.after_initialize do |app|
      if app.config.respond_to?(:assets) && app.config.turbo_boost_streams.precompile_assets
        app.config.assets.precompile += %w[@turbo-boost/streams.js]
      end
    end
  end
end
