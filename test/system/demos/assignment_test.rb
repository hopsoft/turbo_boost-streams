# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class AssignmentTest < ApplicationSystemTestCase
    test "select multiple elements" do
      page.goto demo_url("assignment")

      body_element = page.wait_for_selector("body")
      description_element = page.wait_for_selector("#assignment-demo-description")
      demo_element = page.wait_for_selector("turbo-frame[id=assignment-demo-button]", state: "attached")

      assert_equal "TurboBoost Streams", title
      assert_nil body_element["data-turbo-boost-assignment"]
      refute_equal "text-red-500", description_element["class"]
      assert_equal "We can assign pretty much assign any property value with TurboBoost Streams.", description_element.inner_text

      demo_element.wait_for_selector("button").click
      sleep 0.1

      assert_equal "invoke Assignment", title
      assert_equal "true", body_element["data-turbo-boost-assignment"]
      assert_equal "text-red-500", description_element["class"]
      assert_equal "innerText assigned by TurboBoost Streams invoke", description_element.inner_text
    end
  end
end
