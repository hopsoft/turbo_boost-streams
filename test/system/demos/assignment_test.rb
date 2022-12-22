# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class AssignmentTest < ApplicationSystemTestCase
    test "select multiple elements" do
      visit demo_url("assignment")

      description = find_by_id("assignment-demo-description")
      assert_equal "TurboBoost Streams", title
      assert_nil find("body")["data-turbo-boost-assignment"]
      refute_equal "text-red-500", description[:class]
      assert_equal "We can assign pretty much assign any property value with TurboBoost Streams.", description.text

      demo_button = find("turbo-frame[id=assignment-demo-button] button")
      demo_button.click

      description = find_by_id("assignment-demo-description")
      assert_equal "invoke Assignment", title
      assert_equal "true", find("body")["data-turbo-boost-assignment"]
      assert_equal "text-red-500", find_by_id("assignment-demo-description")[:class]
      assert_equal "innerText assigned by TurboBoost Streams invoke", description.text
    end
  end
end
