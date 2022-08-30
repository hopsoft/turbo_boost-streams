# frozen_string_literal: true

module TurboReady::TagHelper
  def turbo_stream_invoke_tag(method, args: [], selector: nil, camelize: true, id: nil)
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

    %(<turbo-stream action="invoke" target="DOM"><template>#{payload.to_json}</template></turbo-stream>).html_safe
  end
end
