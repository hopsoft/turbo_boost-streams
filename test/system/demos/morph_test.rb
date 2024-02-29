# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class MorphTest < ApplicationSystemTestCase
    test "morph list" do
      page.goto demo_url("morph")

      demo_element = page.wait_for_selector("turbo-frame[id=morph-demo-button]")
      list_element = page.wait_for_selector("#morph-list")

      assert_equal "One", list_element.wait_for_selector("li span").inner_text

      assert_event_dispatch do
        demo_element.wait_for_selector("button").click
      end

      sleep 0.2

      assert_equal "Three", list_element.wait_for_selector("li span").inner_text
    end
  end
end
