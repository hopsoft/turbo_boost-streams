# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class MethodTest < ApplicationSystemTestCase
    test "alert" do
      page.goto demo_url("method")
      message = page.capybara_accept_modal "alert" do
        element("alert-demo-button", true).wait_for_selector("button").click
      end
      wait_for_mutations_finished "alert-demo-button"
      assert_equal "Hello from TurboBoost Streams!", message
    end

    test "alert with delay" do
      page.goto demo_url("method")
      message = page.capybara_accept_modal "alert", wait: 2.1 do
        element("alert-demo-button-with-delay", true).wait_for_selector("button").click
      end
      wait_for_mutations_finished "alert-demo-button-with-delay"
      assert_equal "Hello from TurboBoost Streams with a delay!", message
    end

    test "events with animation and css selector" do
      page.goto demo_url("method")
      assert_event_dispatch wait: 4 do
        element("animate-demo-button", true).wait_for_selector("button").click
      end
    end

    test "select multiple elements" do
      page.goto demo_url("method")

      expected_css_classes = %w[bg-gradient-to-br dark:focus:ring-pink-800 focus:ring-pink-200 from-pink-500 to-orange-400]
      element("multiple-elements-demo-button", true).query_selector_all("button[type=submit]").each do |button|
        assert_equal expected_css_classes.size, (button["class"].split(" ") & expected_css_classes).size
      end

      assert_event_dispatch do
        element("multiple-elements-demo-button", true).wait_for_selector("button").click
      end

      element("multiple-elements-demo-button", true).wait_for_selector("button[type=submit][class~=from-cyan-500]")

      expected_css_classes = %w[bg-gradient-to-r dark:focus:ring-cyan-800 focus:ring-cyan-300 from-cyan-500 to-blue-500]
      element("multiple-elements-demo-button", true).query_selector_all("button[type=submit]").each do |button|
        assert_equal expected_css_classes.size, (button["class"].split(" ") & expected_css_classes).size
      end
    end
  end
end
