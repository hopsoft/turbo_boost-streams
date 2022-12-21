# frozen_string_literal: true

require_relative "../tag_helper"
require_relative "../../../../app/jobs/turbo_boost/streams/broadcast_invoke_job"

# Patch for Turbo::Streams::Broadcasts which is mixed into Turbo::StreamsChannel
# SEE: https://github.com/hotwired/turbo-rails/blob/main/app/channels/turbo/streams/broadcasts.rb
module TurboBoost::Streams::Patches::Broadcasts
  include TurboBoost::Streams::TagHelper

  def broadcast_invoke_to(*streamables, method, **kwargs)
    broadcast_stream_to(*streamables, content: turbo_stream_invoke_tag(method, **kwargs))
  end

  def broadcast_invoke_later_to(*streamables, method, **kwargs)
    TurboBoost::Streams::BroadcastInvokeJob.perform_later(*streamables, method, **kwargs)
  end
end
