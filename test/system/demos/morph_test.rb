# frozen_string_literal: true

require "application_system_test_case"

module TurboReady::Demos
  class MorphTest < ApplicationSystemTestCase
    test "morph list" do
      visit demo_url("morph")

      list = find_by_id("morph-list")
      assert_equal "One", list.first("li").first("span").text

      demo_button = find("turbo-frame[id=morph-demo-button] button")
      demo_button.click

      list = find_by_id("morph-list")
      assert_equal "Three", list.first("li").first("span").text
    end
  end
end
