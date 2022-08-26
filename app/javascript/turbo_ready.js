function invoke () {
  const payload = JSON.parse(this.templateContent.textContent)
  const { id, method, args, receiver, selector } = payload
  let receivers = [self]
  if (selector) receivers = Array.from(document.querySelectorAll(selector))

  if (receiver) {
    receivers = receivers.map(r => {
      let context = r
      const chain = receiver.split('.')
      while (chain.length > 0) context = context[chain.shift()]
      return context
    })
  }

  switch (method) {
    case 'dispatchEvent':
      const evt = new CustomEvent(args[0], args[1] || {})
      receivers.forEach(r => r.dispatchEvent(evt))
      break
    default:
      receivers.forEach(r => r[method].apply(r, args))
  }
}

function initialize () {
  streamActions.invoke = invoke
}

export default { initialize }
