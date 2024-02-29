import morph from './morph'

const invokeEvents = {
  before: 'turbo-boost:stream:before-invoke',
  after: 'turbo-boost:stream:after-invoke',
  finish: 'turbo-boost:stream:finish-invoke'
}

// Invokes the callback on a single receiver with before/after events
function withInvokeEvents(receiver, detail, callback) {
  const { object, target } = receiver
  detail = detail || {}
  detail = { ...detail, object: receiver.object }
  const options = { detail, bubbles: true }

  target.dispatchEvent(new CustomEvent(invokeEvents.before, options))

  // the before event can provide invoke instructions my modifying the event detail
  // For example, { delay: 1000 } will delay the invocation by 1000ms
  let { delay } = detail.invoke || {}
  delay = delay || 0

  const execute = () => {
    const result = callback(object)
    options.detail.result = result
    target.dispatchEvent(new CustomEvent(invokeEvents.after, options))

    let promise
    if (result instanceof Animation) promise = result.finished
    if (result instanceof Promise) promise = result

    if (promise)
      promise
        .then(() => {
          options.detail.promise = 'fulfilled'
          target.dispatchEvent(new CustomEvent(invokeEvents.finish, options))
        })
        .catch(error => {
          options.detail.promise = 'rejected'
          options.detail.error = error
          target.dispatchEvent(new CustomEvent(invokeEvents.finish, options))
        })
    else target.dispatchEvent(new CustomEvent(invokeEvents.finish, options))
  }

  if (delay > 0) setTimeout(execute, delay)
  else execute()
}

function invokeDispatchEvent(method, args, receivers) {
  const eventName = args[0]
  const eventOptions = args[1]
  const detail = { method, eventName, eventOptions }
  receivers.forEach(receiver =>
    withInvokeEvents(receiver, detail, object =>
      object.dispatchEvent(new CustomEvent(eventName, eventOptions))
    )
  )
}

function invokeMorph(method, args, receivers) {
  const html = args[0]
  const detail = { method, html }
  receivers.forEach(receiver => withInvokeEvents(receiver, detail, object => morph.method(object, html)))
}

function invokeAssignment(method, args, receivers) {
  const property = method.slice(0, -1).trim()
  const value = args[0]
  const detail = { method, property, value }
  receivers.forEach(receiver => withInvokeEvents(receiver, detail, object => (object[property] = value)))
}

function invokeMethod(method, args, receivers) {
  const detail = { method, args }
  receivers.forEach(receiver =>
    withInvokeEvents(receiver, detail, object => object[method].apply(object, args))
  )
}

// Performs an invocation on all receivers for the given method and args
function performInvoke(method, args, receivers) {
  // dispatch ................................................................................................
  if (method.match(/^dispatch(Event)?$/)) return invokeDispatchEvent(method, args, receivers)

  // morph ...................................................................................................
  if (method.match(/^morph|mutate$/)) return invokeMorph(method, args, receivers)

  // assignment ..............................................................................................
  if (method.endsWith('=')) return invokeAssignment(method, args, receivers)

  // method ..................................................................................................
  return invokeMethod(method, args, receivers)
}

function invoke() {
  const payload = JSON.parse(this.templateContent.textContent)
  const { id, selector, receiver, method, args, delay } = payload
  let receivers = [{ object: self, target: self }]
  if (selector)
    receivers = Array.from(document.querySelectorAll(selector)).map(el => ({
      object: el,
      target: el
    }))

  if (receiver) {
    receivers = receivers.map(r => {
      let { object, target } = r
      const chain = receiver.split('.')
      while (chain.length > 0) {
        object = object[chain.shift()]
        if (object.dispatchEvent) target = object
      }
      return { object, target }
    })
  }

  if (delay > 0) setTimeout(() => performInvoke(method, args, receivers), delay)
  else performInvoke(method, args, receivers)
}

export { invoke, invokeEvents }
