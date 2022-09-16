window.addEventListener('turbo-ready:demo', event => {
  if (event.target !== window) return
  console.log('received the turbo-ready:demo event', event.target, event)
})

document.addEventListener('turbo-ready:demo', event => {
  console.log('received the turbo-ready:demo event', event.target, event)
})
