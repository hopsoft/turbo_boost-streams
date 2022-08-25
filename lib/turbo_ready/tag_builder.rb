# frozen_string_literal: true

module TurboReady
  # 🙈 Additive monkey patch for Turbo::Streams::TagBuilder
  # SEE: https://github.com/hotwired/turbo-rails/blob/main/app/models/turbo/streams/tag_builder.rb
  module TagBuilder
    def invoke(method, *args, selector: nil, camelize: true, id: nil)
      id ||= SecureRandom.uuid

      method_parts = method.to_s.split(".")
      method_parts = method_parts.map { |part| part.camelize(:lower) } if camelize
      method = method_parts.pop
      receiver = method_parts.join(".")

      if camelize
        args.each do |param|
          next unless param.is_a?(Hash)
          param.transform_keys! { |key| key.to_s.camelize(:lower) }
        end
      end

      payload = {
        id: id,
        method: method,
        args: args,
        receiver: receiver,
        selector: selector
      }

      TurboReady::String.new action(:invoke, "DOM", payload.to_json), turbo_ready_tag_builder: self
    end
  end
end
