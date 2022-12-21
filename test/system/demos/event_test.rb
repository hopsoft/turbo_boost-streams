# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class EventTest < ApplicationSystemTestCase
    test "select multiple elements" do
      visit demo_url("event")

      assert_equal "object", page.evaluate_script("typeof TurboBoostEvents")
      assert_equal "object", page.evaluate_script("typeof TurboBoostEvents['turbo-boost:streams:demo']")
      assert_equal 0, page.evaluate_script("TurboBoostEvents['turbo-boost:streams:demo'].length")

      demo_button = find("turbo-frame[id=event-demo-button] button")
      demo_button.click

      assert page.evaluate_script("TurboBoostEvents['turbo-boost:streams:demo'].length") >= 3

      # first event on window
      assert page.evaluate_script("TurboBoostEvents['turbo-boost:streams:demo'][0].target == window")
      refute page.evaluate_script("TurboBoostEvents['turbo-boost:streams:demo'][0].bubbles")

      # second event on document
      assert page.evaluate_script("TurboBoostEvents['turbo-boost:streams:demo'][1].target == document")
      refute page.evaluate_script("TurboBoostEvents['turbo-boost:streams:demo'][1].bubbles")

      # additional events on button(s)
      assert_equal "BUTTON", page.evaluate_script("TurboBoostEvents['turbo-boost:streams:demo'][2].target.tagName")
      assert page.evaluate_script("TurboBoostEvents['turbo-boost:streams:demo'][2].bubbles")
      assert_equal "The invoke Turbo Stream from TurboBoost::Streams", page.evaluate_script("TurboBoostEvents['turbo-boost:streams:demo'][2].detail.source")
    end
  end
end
