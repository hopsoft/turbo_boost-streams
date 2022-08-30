# frozen_string_literal: true

require "turbo_ready/tag_helper"

module TurboReady::Patches
  # Patch for Turbo::Streams::Broadcasts which is mixed into Turbo::StreamsChannel
  # SEE: https://github.com/hotwired/turbo-rails/blob/main/app/channels/turbo/streams/broadcasts.rb
  module Broadcasts
    include TurboReady::TagHelper

    def broadcast_invoke_to(*streamables, method, **kwargs)
      broadcast_stream_to(*streamables, content: turbo_stream_invoke_tag(method, **kwargs))
    end

    # TODO: update this so it works
    def broadcast_invoke_later_to(*streamables, **rendering)
      Turbo::Streams::BroadcastJob.perform_later stream_name_from(streamables), **rendering
    end
  end
end
