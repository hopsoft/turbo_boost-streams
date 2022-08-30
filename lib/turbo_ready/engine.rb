# frozen_string_literal: true

require "turbo_ready/patches"

module TurboReady
  class Engine < ::Rails::Engine
    config.after_initialize do
      ::Turbo::Streams::TagBuilder.send :include, TurboReady::Patches::TagBuilder
      ::Turbo::Streams::Broadcasts.send :include, TurboReady::Patches::Broadcasts
      ::Turbo::Broadcastable.send :include, TurboReady::Patches::Broadcastable
    end
  end
end
