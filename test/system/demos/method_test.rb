# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class MethodTest < ApplicationSystemTestCase
    test "alert" do
      page.goto demo_url("method")

      demo_element = page.wait_for_selector("turbo-frame[id=alert-demo-button]")

      message = page.capybara_accept_modal "alert" do
        demo_element.wait_for_selector("button").click
      end

      assert_equal "Hello from TurboBoost Streams!", message
    end

    test "alert with delay" do
      page.goto demo_url("method")

      demo_element = page.wait_for_selector("turbo-frame[id=alert-demo-button-with-delay]")

      message = page.capybara_accept_modal "alert", wait: 2.1 do
        demo_element.wait_for_selector("button").click
      end

      assert_equal "Hello from TurboBoost Streams with a delay!", message
    end

    test "events with animation and css selector" do
      page.goto demo_url("method")

      demo_element = page.wait_for_selector("turbo-frame[id=animate-demo-button]")

      assert_event_dispatch wait: 3 do
        demo_element.wait_for_selector("button").click
      end
    end

    test "select multiple elements" do
      page.goto demo_url("method")

      demo_element = page.wait_for_selector("turbo-frame[id=multiple-elements-demo-button]")
      expected_css_classes = %w[bg-gradient-to-br dark:focus:ring-pink-800 focus:ring-pink-200 from-pink-500 to-orange-400]
      page.query_selector_all("button[type=submit]").each do |button|
        assert_equal expected_css_classes.size, (button["class"].split(" ") & expected_css_classes).size
      end

      assert_event_dispatch invocations: 10, wait: 1 do
        demo_element.wait_for_selector("button").click
        sleep 0.1
      end

      expected_css_classes = %w[bg-gradient-to-r dark:focus:ring-cyan-800 focus:ring-cyan-300 from-cyan-500 to-blue-500]
      page.query_selector_all("button[type=submit]").each do |button|
        assert_equal expected_css_classes.size, (button["class"].split(" ") & expected_css_classes).size
      end
    end
  end
end
