# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class IndexTest < ApplicationSystemTestCase
    test "turbo-boost streams loaded" do
      page.goto demos_url
      assert_equal "object", js("typeof TurboBoost")
      assert_equal "object", js("typeof TurboBoost.Streams")
      assert_equal "function", js("typeof TurboBoost.Streams.invoke")
    end
  end
end
