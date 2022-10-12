function dispatch (targets, name, options = {}) {
  const evt = new CustomEvent(name, options)
  targets.forEach(t => t.dispatchEvent(evt))
}

export default dispatch
