// app/javascript/application.js
import '@hotwired/turbo-rails'
import TurboReady from 'turbo_ready' // <- import first

TurboReady.initialize(Turbo.StreamActions) // then Add TurboReady stream actions to Turbo
