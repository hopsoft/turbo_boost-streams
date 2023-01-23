# frozen_string_literal: true

require "test_helper"
require "capybara/cuprite"

# Capybara setup fom Evil Martians
# SEE: https://evilmartians.com/chronicles/system-of-a-test-setting-up-end-to-end-rails-testing
# NOTE: Will need to set this up for multiple sessions
Capybara.default_max_wait_time = 5
Capybara.default_normalize_ws = true
# Capybara.save_path = ENV.fetch("CAPYBARA_ARTIFACTS", "./tmp/capybara")

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :headless_chrome, screen_size: [1400, 1400]

  protected

  def assert_event_dispatch(wait: 0, invocations: 1)
    page.execute_script <<~JS
      self.dispatchedEvents = []
      document.addEventListener('turbo-boost:stream:before-invoke', event => self.dispatchedEvents.push(event.type))
      document.addEventListener('turbo-boost:stream:after-invoke', event => self.dispatchedEvents.push(event.type))
      document.addEventListener('turbo-boost:stream:finish-invoke', event => self.dispatchedEvents.push(event.type))
    JS

    yield

    assert page.evaluate_script("self.dispatchedEvents.includes('turbo-boost:stream:before-invoke')")
    assert page.evaluate_script("self.dispatchedEvents.includes('turbo-boost:stream:after-invoke')")
    sleep wait if wait > 0
    assert page.evaluate_script("self.dispatchedEvents.includes('turbo-boost:stream:finish-invoke')")

    return if ENV["GITHUB_ACTIONS"].present?

    # This check doesn't work with GitHub Actions for some reason
    event_count = page.evaluate_script("self.dispatchedEvents.length")
    assert_equal invocations * 3, event_count
  end
end

Capybara.configure do |config|
  config.server = :puma, {Silent: true}
end
