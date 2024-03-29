# frozen_string_literal: true

require "test_helper"
require "capybara-playwright-driver"

Capybara.default_max_wait_time = 8
Capybara.default_retry_interval = 0.2
Capybara.default_normalize_ws = true
Capybara.save_path = "tmp/capybara"

BROWSER = :chromium

Capybara.register_driver :playwright do |app|
  Capybara::Playwright::Driver.new(
    app,
    browser_type: BROWSER,
    headless: true,
    playwright_cli_executable_path: "npx playwright"
  )
end

Capybara.default_driver = :playwright
Capybara.javascript_driver = :playwright

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :playwright

  attr_reader :page

  def before_setup
    @playwright_exec = Playwright.create(playwright_cli_executable_path: "npx playwright")
    @playwright = @playwright_exec.playwright
    @browser = @playwright.public_send(BROWSER).launch
    @context = @browser.new_context # prepare new browser window
    @page = @context.new_page
    @page.set_default_timeout Capybara.default_max_wait_time * 1_000
  end

  def after_teardown
    @browser.close
    @playwright_exec.stop
  end

  # Wrapper for Playwright's page.evaluate method which evaluates
  # JavaScript code in the context of the current page.
  def js(...)
    @page.evaluate(...)
  end

  # Returns an element that matches the given testid attribute value.
  #
  # @param testid [String,Symbol] The element's data-testid attribute value
  # @param handle [Boolean] Whether to return the element handle (default: false)
  # @return [Playwright::ElementLocator,Playwright::ElementHandle] The element
  def element(testid, handle = false)
    el = page.get_by_test_id(testid.to_s)
    handle ? el.element_handle : el
  end

  # Checks if an element is tracking active mutations.
  # SEE: test/dummy/app/javascript/tests/index.js
  #
  # @param testid [String] the element's testid
  # @return [Boolean] returns whether or not the element has active mutations
  def element_mutated?(testid)
    js "element => !!element.mutations", arg: element(testid).element_handle
  end

  # Waits for an element's mutation tracking to reset, then yields the element handle,
  # and finally waits for the element to be mutated again.
  # SEE: test/dummy/app/javascript/tests/index.js
  #
  # @param testid [String,Symbol] The element's data-testid attribute value
  # @param timeout [Integer] The maximum time to wait (default: 5s)
  # @param interval [Integer] The time interval to wait between checks (default: 20ms)
  def wait_for_mutations(testid, timeout: 5.seconds, interval: 0.02)
    wait_for_mutations_finished testid, timeout: timeout, interval: interval
    yield element(testid).element_handle if block_given?
    Timeout.timeout timeout.to_i do
      sleep interval.to_f until element_mutated?(testid)
    end
  rescue Timeout::Error
    sleep 0.5 # last ditch effort to avoid flakiness
    yield element(testid).element_handle if block_given?
  end

  # Waits for an element's mutation tracking to reset, then yields the element handle.
  # SEE: test/dummy/app/javascript/tests/index.js
  #
  # @param testid [String,Symbol] The element's data-testid attribute value
  # @param timeout [Integer] The maximum time to wait (default: 5s)
  # @param interval [Integer] The time interval to wait between checks (default: 20ms)
  def wait_for_mutations_finished(testid, timeout: 5.seconds, interval: 0.02)
    Timeout.timeout timeout.to_i do
      sleep interval.to_f while element_mutated?(testid)
    end
    yield element(testid).element_handle if block_given?
  rescue Timeout::Error
    sleep 0.5 # last ditch effort to avoid flakiness
    yield element(testid).element_handle if block_given?
  end

  # TODO: Update to use testid
  # Waits for an element to be detached from the DOM.
  #
  # @param element [Playwright::ElementHandle] The element
  # @param timeout [Integer] The maximum time to wait (default: 5s)
  # @param interval [Integer] The time interval to wait between checks (default: 20ms)
  def wait_for_detach(element, timeout: 5.seconds, interval: 0.02)
    Timeout.timeout timeout.to_i do
      sleep interval.to_f while page.evaluate("(element) => element.isConnected", arg: element)
    end
  rescue Timeout::Error
    sleep 0.5 # last ditch effort to avoid flakiness
  end

  # Asserts that `turbo-boost:stream:NAME` events have been dispatched.
  #
  # @param wait [Integer] the amount of time to wait before checking `turbo-boost:stream:finish-invoke` (default: 0.1s)
  # @yield a block of code that will trigger a TurboBoost Stream
  def assert_event_dispatch(wait: 0.1)
    js <<~JS
      self.dispatchedEvents = []
      document.addEventListener('turbo-boost:stream:before-invoke', event => self.dispatchedEvents.push(event.type))
      document.addEventListener('turbo-boost:stream:after-invoke', event => self.dispatchedEvents.push(event.type))
      document.addEventListener('turbo-boost:stream:finish-invoke', event => self.dispatchedEvents.push(event.type))
    JS
    yield if block_given?
    sleep wait # wait for promise to resolve if invoked method returns a promise
    assert js("self.dispatchedEvents.includes('turbo-boost:stream:before-invoke')")
    assert js("self.dispatchedEvents.includes('turbo-boost:stream:after-invoke')")
    assert js("self.dispatchedEvents.includes('turbo-boost:stream:finish-invoke')")
  end
end
