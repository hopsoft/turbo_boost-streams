# frozen_string_literal: true

require_relative "../string_wrapper"
require_relative "../tag_helper"

# Patch for Turbo::Streams::TagBuilder typically exposed as `turbo_stream`
# SEE: https://github.com/hotwired/turbo-rails/blob/main/app/models/turbo/streams/tag_builder.rb
module TurboReady::Patches::TagBuilder
  include TurboReady::TagHelper

  def invoke(method, args: [], selector: nil, camelize: true, id: nil)
    TurboReady::StringWrapper.new \
      turbo_stream_invoke_tag(method, args: args, selector: selector, camelize: camelize, id: id)
  end
end
