# frozen_string_literal: true

class TurboBoost::Streams::TagBuilderTest < ActiveSupport::TestCase
  include TurboBoost::Streams::Patches::TagBuilder

  test "invoke returns a TurboBoost::Streams::StringWrapper" do
    actual = invoke("console.log", args: ["Hello World!"])
    assert actual.is_a?(TurboBoost::Streams::StringWrapper)
  end

  test "invoke returns a wrapped string with the expected value" do
    actual = invoke("console.log", args: ["Hello World!"], id: 1).to_s
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"receiver\":\"console\",\"method\":\"log\",\"args\":[\"Hello World!\"]}</template></turbo-stream>"
    assert_equal expected, actual
  end

  test "invoke returns a wrapped string with the expected value when chained" do
    actual = invoke("console.log", args: ["Message 1"], id: 1).invoke("console.log", args: ["Message 2"], id: 2).to_s
    expected = "<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"1\",\"receiver\":\"console\",\"method\":\"log\",\"args\":[\"Message 1\"]}</template></turbo-stream>\n<turbo-stream action=\"invoke\" target=\"DOM\"><template>{\"id\":\"2\",\"receiver\":\"console\",\"method\":\"log\",\"args\":[\"Message 2\"]}</template></turbo-stream>"
    assert_equal expected, actual
  end
end
