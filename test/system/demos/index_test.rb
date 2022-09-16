require "application_system_test_case"

module TurboReady::Demos
  class IndexTest < ApplicationSystemTestCase
    test "turbo ready loaded" do
      visit demos_url
      assert page.evaluate_script("typeof TurboReady") == "object"
      assert page.evaluate_script("typeof TurboReady.initialize") == "function"
    end
  end
end
