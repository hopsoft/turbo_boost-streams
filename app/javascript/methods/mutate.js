import alpine from 'alpinejs'
import morph from '@alpinejs/morph'

alpine.plugin(morph)

const input = /INPUT/i
const inputTypes = /date|datetime-local|email|month|number|password|range|search|tel|text|time|url|week/i
const textarea = /TEXTAREA/i

function updating (el, toEl, childrenOnly, skip) {
  if (el.nodeType !== Node.ELEMENT_NODE) return
  if (el !== document.activeElement) return

  const protect =
    el.tagName.match(textarea) ||
    (el.tagName.match(input) && el.getAttribute('type').match(inputTypes))

  if (protect) return skip()
}

function mutate (elements, html) {
  elements.forEach(element => alpine.morph(element, html, { updating }))
}

export default mutate
