# frozen_string_literal: true

require "turbo_ready/string_wrapper"
require "turbo_ready/tag_helper"

module TurboReady::Patches
  # Patch for Turbo::Streams::TagBuilder exposed as `turbo_stream` via
  # - Turbo::StreamsHelper (views)
  # - Turbo::Streams::TurboStreamsTagBuilder (controllers)
  # SEE: https://github.com/hotwired/turbo-rails/blob/main/app/models/turbo/streams/tag_builder.rb
  module TagBuilder
    include TurboReady::TagHelper

    def invoke(method, args: [], selector: nil, camelize: true, id: nil)
      TurboReady::StringWrapper.new \
        turbo_stream_invoke_tag(method, args: args, selector: selector, camelize: camelize, id: id)
    end
  end
end
