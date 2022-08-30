# frozen_string_literal: true

class TurboReady::StringWrapper
  include TurboReady::TagHelper
  attr_reader :turbo_stream_string

  delegate_missing_to :turbo_stream_string

  def initialize(turbo_stream_string, turbo_stream_strings: Set.new)
    @turbo_stream_string = turbo_stream_string
    @turbo_stream_strings = turbo_stream_strings
    @turbo_stream_strings << turbo_stream_string
  end

  def invoke(method, **kwargs)
    TurboReady::StringWrapper.new \
      turbo_stream_invoke_tag(method, **kwargs), turbo_stream_strings: turbo_stream_strings
  end

  def flush
    turbo_stream_strings.to_a.join("\n").html_safe
  ensure
    turbo_stream_strings.clear
  end

  alias_method :to_s, :flush

  private

  def turbo_stream_strings
    @turbo_stream_strings ||= Set.new
  end
end
