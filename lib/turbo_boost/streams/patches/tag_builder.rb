# frozen_string_literal: true

require_relative "../string_wrapper"
require_relative "../tag_helper"

# Patch for Turbo::Streams::TagBuilder typically exposed as `turbo_stream`
# SEE: https://github.com/hotwired/turbo-rails/blob/main/app/models/turbo/streams/tag_builder.rb
module TurboBoost::Streams::Patches::TagBuilder
  include TurboBoost::Streams::TagHelper

  def invoke(...)
    TurboBoost::Streams::StringWrapper.new turbo_stream_invoke_tag(...)
  end
end
