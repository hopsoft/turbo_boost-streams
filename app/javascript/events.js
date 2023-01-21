const events = {
  before: 'turbo-boost:stream:before',
  after: 'turbo-boost:stream:after'
}

function dispatch (name, target, detail = {}) {
  const options = { detail: detail || {}, bubbles: true }
  target = target || document
  target.dispatchEvent(new CustomEvent(name, options))
}

export function performWithEvents (target, detail = {}, callback) {
  dispatch(events.before, target, detail)
  callback()
  dispatch(events.after, target, detail)
}
