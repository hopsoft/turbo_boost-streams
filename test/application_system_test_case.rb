# frozen_string_literal: true

require "test_helper"
require "capybara-playwright-driver"

class CapybaraNullDriver < Capybara::Driver::Base
  def needs_server?
    true
  end
end

Capybara.register_driver(:null) { CapybaraNullDriver.new }
Capybara.default_driver = :null
Capybara.default_max_wait_time = 12
Capybara.default_normalize_ws = true
Capybara.save_path = "tmp/capybara"
Capybara.configure do |config|
  config.server = :puma, {Silent: true}
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :null

  def self.playwright
    @playwright ||= Playwright.create(playwright_cli_executable_path: Rails.root.join("../../node_modules/.bin/playwright"))
  end

  alias_method :orig_page, :page
  attr_reader :playwright_browser, :playwright_page
  alias_method :page, :playwright_page

  def js(...)
    page.evaluate(...)
  end

  def before_setup
    super
    base_url = Capybara.current_session.server.base_url
    @playwright_browser = self.class.playwright.playwright.chromium.launch(headless: true)
    @playwright_page = @playwright_browser.new_page(baseURL: base_url)
    playwright_page.set_default_timeout Capybara.default_max_wait_time * 1_000
  end

  def after_teardown
    super
    playwright_browser&.close
  end

  protected

  def assert_event_dispatch(wait: 0, invocations: 1)
    js <<~JS
      self.dispatchedEvents = []
      document.addEventListener('turbo-boost:stream:before-invoke', event => self.dispatchedEvents.push(event.type))
      document.addEventListener('turbo-boost:stream:after-invoke', event => self.dispatchedEvents.push(event.type))
      document.addEventListener('turbo-boost:stream:finish-invoke', event => self.dispatchedEvents.push(event.type))
    JS

    yield
    sleep 0.1 # wait for turbo streams to execute

    assert js("self.dispatchedEvents.includes('turbo-boost:stream:before-invoke')")
    assert js("self.dispatchedEvents.includes('turbo-boost:stream:after-invoke')")
    sleep wait if wait > 0 # wait for promise to resolve if invoked method returns a promise
    assert js("self.dispatchedEvents.includes('turbo-boost:stream:finish-invoke')")

    return if ENV["GITHUB_ACTIONS"].present?

    # This check doesn't work with GitHub Actions for some reason
    event_count = js("self.dispatchedEvents.length")
    assert_equal invocations * 3, event_count
  end
end

Capybara.configure do |config|
  config.server = :puma, {Silent: true}
end
