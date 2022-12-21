# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class MethodTest < ApplicationSystemTestCase
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

      demo_button.click

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
