import { Idiomorph } from 'idiomorph'

const input = /INPUT/i
const inputTypes = /date|datetime-local|email|month|number|password|range|search|tel|text|time|url|week/i
const textarea = /TEXTAREA/i

const morphAllowed = node => {
  if (node.nodeType !== Node.ELEMENT_NODE) return true
  if (node !== document.activeElement) return true

  // don't morph active textarea
  if (node.tagName.match(textarea)) return false

  // don't morph active inputs
  return node.tagName.match(input) && node.getAttribute('type').match(inputTypes)
}

const callbacks = {
  beforeNodeMorphed: (oldNode, _newNode) => morphAllowed(oldNode),
}

const morph = (element, html) => Idiomorph.morph(element, html, { callbacks })

export default morph
