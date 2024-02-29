# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class MorphTest < ApplicationSystemTestCase
    test "morph list" do
      page.goto demo_url("morph")
      assert_equal "One", element("morph-list", true).wait_for_selector("li span").inner_text
      wait_for_mutations "morph-demo-button" do
        element("morph-demo-button", true).wait_for_selector("button").click
      end
      wait_for_mutations_finished "morph-demo-button"
      assert_equal "Three", element("morph-list", true).wait_for_selector("li span").inner_text
    end
  end
end
