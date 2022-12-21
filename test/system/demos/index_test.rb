# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class IndexTest < ApplicationSystemTestCase
    test "turbo-boost streams loaded" do
      visit demos_url
      assert page.evaluate_script("typeof TurboBoost") == "object"
      assert page.evaluate_script("typeof TurboBoost.Streams") == "object"
      assert page.evaluate_script("typeof TurboBoost.Streams.invoke") == "function"
    end
  end
end
