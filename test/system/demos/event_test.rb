# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class EventTest < ApplicationSystemTestCase
    test "select multiple elements" do
      page.goto demo_url("event")
      wait_for_mutations_finished "event-demo-button"

      assert_equal "object", js("typeof TurboBoostEvents")
      assert_equal "object", js("typeof TurboBoostEvents['turbo-boost:streams:demo']")
      assert_equal 0, js("TurboBoostEvents['turbo-boost:streams:demo'].length")

      wait_for_mutations "event-demo-button" do
        element("event-demo-button", true).wait_for_selector("button").click
      end
      wait_for_mutations_finished "event-demo-button"

      assert js("TurboBoostEvents['turbo-boost:streams:demo'].length") >= 3

      # first event on window
      assert js("TurboBoostEvents['turbo-boost:streams:demo'][0].target == window")
      refute js("TurboBoostEvents['turbo-boost:streams:demo'][0].bubbles")

      # second event on document
      assert js("TurboBoostEvents['turbo-boost:streams:demo'][1].target == document")
      refute js("TurboBoostEvents['turbo-boost:streams:demo'][1].bubbles")

      # additional events on button(s)
      assert_equal "BUTTON", js("TurboBoostEvents['turbo-boost:streams:demo'][2].target.tagName")
      assert js("TurboBoostEvents['turbo-boost:streams:demo'][2].bubbles")
      assert_equal "The invoke Turbo Stream from TurboBoost Streams", js("TurboBoostEvents['turbo-boost:streams:demo'][2].detail.source")
    end
  end
end
