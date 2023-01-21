// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import '@hotwired/turbo-rails'
import 'flowbite'
import '@turbo-boost/streams'
import './controllers'
import './demos/event'

addEventListener('turbo-boost:stream:before', event =>
  console.log('turbo-boost:stream:before', event)
)

addEventListener('turbo-boost:stream:after', event =>
  console.log('turbo-boost:stream:after', event)
)

// Force all scripts in <head> to reload/reparse after a Turbo visit.
// This ensures that libs which don't work with Turbo Drive...
// (i.e. the body being replaced without reparsing scripts in <head>)
// ...will continue to work.
document.addEventListener('turbo:load', event => {
  document.querySelectorAll('script[type=importmap]').forEach(el => {
    const parent = el.parentNode
    el.remove()
    parent.appendChild(el)
  })
})
