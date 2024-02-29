import { Idiomorph } from 'idiomorph'
import schema from './schema'

let _method
let _delay = 0

const trixEditor = /TRIX-EDITOR/i

function isElement(node) {
  return node.nodeType === Node.ELEMENT_NODE
}

function isTurboPermanent(node) {
  if (!isElement(node)) return false
  return (
    node.hasAttribute(schema.turboPermanentAttribute) &&
    node.getAttribute(schema.turboPermanentAttribute) !== 'false'
  )
}

function isActive(node) {
  if (!isElement(node)) return false
  return node === document.activeElement
}

function morphAllowed(node) {
  if (isTurboPermanent(node)) return false
  if (isActive(node) && node.tagName.match(trixEditor)) return false
  return true
}

const defaultOptions = {
  callbacks: { beforeNodeMorphed: (oldNode, _newNode) => morphAllowed(oldNode) },
  morphStyle: 'outerHTML',
  ignoreActiveValue: true,
  head: { style: 'merge' }
}

function morph(element, html, options = {}) {
  const callbacks = { ...defaultOptions.callbacks, ...options.callbacks }
  options = { ...defaultOptions, ...options, callbacks }

  return new Promise(resolve => {
    setTimeout(() => {
      Idiomorph.morph(element, html, options)
      resolve()
    }, _delay)
  })
}

_method = morph

export default {
  get delay() {
    return _delay
  },

  set delay(ms) {
    _delay = ms
  },

  get method() {
    return _method
  },

  set method(fn) {
    _method = fn
  }
}
