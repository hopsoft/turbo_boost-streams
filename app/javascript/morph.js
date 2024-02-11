import alpine from 'alpinejs'
import alpineMorph from '@alpinejs/morph'

alpine.plugin(alpineMorph)

const input = /INPUT/i
const inputTypes = /date|datetime-local|email|month|number|password|range|search|tel|text|time|url|week/i
const textarea = /TEXTAREA/i

function updating(el, toEl, childrenOnly, skip) {
  if (el.nodeType !== Node.ELEMENT_NODE) return
  if (el !== document.activeElement) return

  const protect =
    el.tagName.match(textarea) || (el.tagName.match(input) && el.getAttribute('type').match(inputTypes))

  if (protect) return skip()
}

export default function morph(element, html) {
  alpine.morph(element, html, { updating })
}
