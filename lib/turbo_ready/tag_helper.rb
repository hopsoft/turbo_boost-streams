# frozen_string_literal: true

module TurboReady::TagHelper
  def turbo_stream_invoke_tag(method, args: [], selector: nil, camelize: true, id: nil)
    id ||= SecureRandom.uuid
    payload = HashWithIndifferentAccess.new(id: id, selector: selector)
    payload.merge! method_details(method, args: args, camelize: camelize)
    payload.select! { |_, v| v.present? }
    %(<turbo-stream action="invoke" target="DOM"><template>#{payload.to_json}</template></turbo-stream>).html_safe
  end

  private

  def method_details(method, args: [], camelize: true)
    if camelize
      method = camelize_method(method)
      args = camelize_args(args)
    end

    method_parts = method.to_s.split(".")

    HashWithIndifferentAccess.new(
      receiver: method_parts[0..-2].join("."),
      method: method_parts.last,
      args: args
    )
  end

  def camelize_method(method)
    method.to_s.split(".").map { |s| s.camelize(:lower) }.join(".")
  end

  def camelize_args(args = [])
    args.map do |param|
      if param.is_a? Hash
        param.transform_keys { |key| key.to_s.camelize(:lower) }
      else
        param
      end
    end
  end
end
