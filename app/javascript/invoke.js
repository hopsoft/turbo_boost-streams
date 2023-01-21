import dispatch from './methods/dispatch'
import mutate from './methods/mutate'
import { performWithEvents } from './events'

function performEach (receivers, detail, callback) {
  receivers.forEach(receiver => {
    const { object, target } = receiver
    performWithEvents(target, { ...detail, object }, () => callback(object))
  })
}

function perform (method, args, receivers) {
  // dispatch / dispatchEvent ................................................................................
  if (method.match(/^dispatch(Event)?$/)) {
    const eventName = args[0]
    const eventOptions = args[1]
    const detail = { method, eventName, eventOptions }
    return performEach(receivers, detail, obj =>
      dispatch(obj, eventName, eventOptions)
    )
  }

  // morph / mutate ..........................................................................................
  if (method.match(/^morph|mutate$/)) {
    const html = args[0]
    const detail = { method, html }
    return performEach(receivers, detail, obj => mutate(obj, html))
  }

  // property assignment .....................................................................................
  if (method.endsWith('=')) {
    const property = method.slice(0, -1).trim()
    const value = args[0]
    const detail = { method, property, value }
    return performEach(receivers, detail, obj => (obj[property] = value))
  }

  // method invocation .......................................................................................
  const detail = { method, args }
  return performEach(receivers, detail, obj => obj[method].apply(obj, args))
}

function invoke () {
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

  if (delay > 0) setTimeout(() => perform(method, args, receivers), delay)
  else perform(method, args, receivers)
}

export default invoke
