import { Idiomorph } from 'idiomorph'
import schema from './schema'

const trixEditor = /TRIX-EDITOR/i

const defaultOptions = {
  callbacks: { beforeNodeMorphed: (oldNode, _newNode) => morphAllowed(oldNode) },
  morphStyle: 'outerHTML',
  ignoreActiveValue: true,
  head: { style: 'morph' }
}

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

function morph(element, html, options = {}) {
  const callbacks = { ...defaultOptions.callbacks, ...options.callbacks }
  options = { ...defaultOptions, ...options, callbacks }
  Idiomorph.morph(element, html, options)
}

export default morph
