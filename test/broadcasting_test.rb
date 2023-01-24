# frozen_string_literal: true

require "test_helper"
require "action_cable"

class TurboBoost::Streams::BroadcastingTest < ActionCable::Channel::TestCase
  include ActiveJob::TestHelper
  include TurboBoost::Streams::TagHelper

  setup do
    @message = Message.create(id: 1, content: "Hello!")
    @expected = turbo_stream_invoke_tag("console.log", args: ["Hello World!"], id: 1)
  end

  test "Turbo::StreamsChannel.broadcast_invoke_to" do
    assert_broadcast_on "stream", @expected do
      Turbo::StreamsChannel.broadcast_invoke_to "stream", "console.log", args: ["Hello World!"], id: 1
    end
  end

  test "Turbo::StreamsChannel.broadcast_invoke_later_to" do
    assert_broadcast_on "stream", @expected do
      perform_enqueued_jobs do
        Turbo::StreamsChannel.broadcast_invoke_later_to "stream", "console.log", args: ["Hello World!"], id: 1
      end
    end
  end

  test "@message.broadcast_invoke_to" do
    assert_broadcast_on "stream", @expected do
      @message.broadcast_invoke_to "stream", "console.log", args: ["Hello World!"], id: 1
    end
  end

  test "@message.broadcast_invoke_later_to" do
    assert_broadcast_on "stream", @expected do
      perform_enqueued_jobs do
        @message.broadcast_invoke_later_to "stream", "console.log", args: ["Hello World!"], id: 1
      end
    end
  end

  test "@message.broadcast_invoke" do
    stream = Turbo::StreamsChannel.verified_stream_name(Turbo::StreamsChannel.signed_stream_name(@message))
    assert_broadcast_on stream, @expected do
      @message.broadcast_invoke "console.log", args: ["Hello World!"], id: 1
    end
  end

  test "@message.broadcast_invoke_later" do
    stream = Turbo::StreamsChannel.verified_stream_name(Turbo::StreamsChannel.signed_stream_name(@message))
    assert_broadcast_on stream, @expected do
      perform_enqueued_jobs do
        @message.broadcast_invoke_later "console.log", args: ["Hello World!"], id: 1
      end
    end
  end
end
