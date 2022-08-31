# frozen_string_literal: true

class TurboReady::BroadcastInvokeJob < ActiveJob::Base
  include TurboReady::TagHelper

  def perform(*streamables, method, **kwargs)
    Turbo::StreamsChannel.broadcast_stream_to(*streamables, content: turbo_stream_invoke_tag(method, **kwargs))
  end
end
