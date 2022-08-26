# frozen_string_literal: true

module TurboReady
  class String
    attr_reader :ruby_string, :turbo_ready_tag_builder

    delegate_missing_to :ruby_string

    def initialize(ruby_string, turbo_ready_tag_builder:)
      @ruby_string = ruby_string
      @turbo_ready_tag_builder = turbo_ready_tag_builder
      turbo_ready_tags << ruby_string
    end

    def turbo_ready_tags
      @turbo_ready_tags ||= Set.new
    end

    def invoke(method, *args, **kwargs)
      prior_turbo_ready_tags = turbo_ready_tags
      turbo_ready_tag_builder.invoke(method, *args, **kwargs).tap do |turbo_ready_string|
        turbo_ready_string.instance_eval do
          @turbo_ready_tags = prior_turbo_ready_tags
          @turbo_ready_tags << turbo_ready_string.ruby_string
        end
      end
    end

    def flush
      turbo_ready_tags.to_a.join("\n").html_safe
    ensure
      turbo_ready_tags.clear
    end

    alias_method :to_s, :flush
  end
end
