function dispatch (target, name, options = {}) {
  const evt = new CustomEvent(name, options)
  target.dispatchEvent(evt)
}

export default dispatch
