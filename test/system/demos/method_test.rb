# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class MethodTest < ApplicationSystemTestCase
    test "alert" do
      visit demo_url("method")

      demo_button = find("turbo-frame[id=alert-demo-button] button")

      accept_alert text: "Hello from TurboBoost Streams!" do
        demo_button.click
      end
    end

    test "alert with delay" do
      visit demo_url("method")

      demo_button = find("turbo-frame[id=alert-demo-button-with-delay] button")

      accept_alert text: "Hello from TurboBoost Streams with a delay!" do
        demo_button.click
      end
    end

    test "events with animation and css selector" do
      visit demo_url("method")

      demo_button = find("turbo-frame[id=animate-demo-button] button")

      assert_event_dispatch wait: 3 do
        demo_button.click
      end
    end

    test "select multiple elements" do
      visit demo_url("method")

      demo_button = find("turbo-frame[id=multiple-elements-demo-button] button")

      submit_buttons = find_all("button[type=submit]")
      expected_css_classes = %w[bg-gradient-to-br dark:focus:ring-pink-800 focus:ring-pink-200 from-pink-500 to-orange-400]
      submit_buttons.each do |button|
        expected_css_classes.each do |css_class|
          assert_equal expected_css_classes.size, (button[:class].split(" ") & expected_css_classes).size
        end
      end

      assert_event_dispatch invocations: 10, wait: 0.1 do
        demo_button.click
      end

      submit_buttons = find_all("button[type=submit]")
      expected_css_classes = %w[bg-gradient-to-r dark:focus:ring-cyan-800 focus:ring-cyan-300 from-cyan-500 to-blue-500]
      submit_buttons.each do |button|
        expected_css_classes.each do |css_class|
          assert_equal expected_css_classes.size, (button[:class].split(" ") & expected_css_classes).size
        end
      end
    end
  end
end
