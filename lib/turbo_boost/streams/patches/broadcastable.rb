# frozen_string_literal: true

# Patch for Turbo::Broadcastable which is mixed into ActiveRecord
# SEE: https://github.com/hotwired/turbo-rails/blob/main/app/models/concerns/turbo/broadcastable.rb
module TurboBoost::Streams::Patches::Broadcastable
  def broadcast_invoke_to(*streamables, method, **kwargs)
    Turbo::StreamsChannel.broadcast_invoke_to(*streamables, method, **kwargs)
  end

  def broadcast_invoke_later_to(*streamables, method, **kwargs)
    Turbo::StreamsChannel.broadcast_invoke_later_to(*streamables, method, **kwargs)
  end

  def broadcast_invoke(method, **kwargs)
    broadcast_invoke_to(self, method, **kwargs)
  end

  def broadcast_invoke_later(method, **kwargs)
    broadcast_invoke_later_to(self, method, **kwargs)
  end
end
