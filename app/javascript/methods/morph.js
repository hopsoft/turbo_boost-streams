import alpineMorph from '@alpinejs/morph'

const input = /INPUT/i
const inputTypes = /date|datetime-local|email|month|number|password|range|search|tel|text|time|url|week/i
const textarea = /TEXTAREA/i

function updating (el, toEl, childrenOnly, skip) {
  let protect = false
  protect = el.match(textarea)
  protect =
    protect || (el.match(input) && el.getAttribute('type').match(inputTypes))
  if (protect && el === document.activeElement) skip()
}

function morph (elements, html) {
  elements.forEach(element => alpineMorph(element, html, { updating }))
}

export default morph
