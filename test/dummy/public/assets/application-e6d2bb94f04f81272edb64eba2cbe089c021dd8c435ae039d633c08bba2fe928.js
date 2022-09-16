// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import '@hotwired/turbo-rails'
import TurboReady from 'turbo_ready'
import './demos/event'

TurboReady.initialize(Turbo.StreamActions)

window.TurboReady = TurboReady;
