# frozen_string_literal: true

class TurboBoost::Streams::StringWrapper
  include TurboBoost::Streams::TagHelper
  attr_reader :turbo_stream_string

  delegate_missing_to :turbo_stream_string

  def initialize(turbo_stream_string, turbo_stream_strings: Set.new)
    @turbo_stream_string = turbo_stream_string
    @turbo_stream_strings = turbo_stream_strings
    @turbo_stream_strings << turbo_stream_string
  end

  def invoke(...)
    TurboBoost::Streams::StringWrapper.new turbo_stream_invoke_tag(...), turbo_stream_strings: turbo_stream_strings
  end

  def to_s
    turbo_stream_strings.to_a.join("\n").html_safe
  end

  private

  def turbo_stream_strings
    @turbo_stream_strings ||= Set.new
  end
end
