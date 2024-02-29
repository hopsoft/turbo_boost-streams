# frozen_string_literal: true

require "application_system_test_case"

module TurboBoost::Streams::Demos
  class AssignmentTest < ApplicationSystemTestCase
    test "select multiple elements" do
      page.goto demo_url("assignment")

      assert_equal "TurboBoost Streams", title
      assert_nil page.wait_for_selector("body")["data-turbo-boost-assignment"]
      refute_equal "text-red-500", element("assignment-demo-description")["class"]
      assert_equal "We can assign pretty much assign any property value with TurboBoost Streams.", element("assignment-demo-description").inner_text

      wait_for_mutations "assignment-demo-button" do
        element("assignment-demo-button", true).wait_for_selector("button").click
      end
      wait_for_mutations_finished "assignment-demo-button"

      assert_equal "invoke Assignment", title
      assert_equal "true", page.wait_for_selector("body")["data-turbo-boost-assignment"]
      assert_equal "text-red-500", element("assignment-demo-description")["class"]
      assert_equal "innerText assigned by TurboBoost Streams invoke", element("assignment-demo-description").inner_text
    end
  end
end
