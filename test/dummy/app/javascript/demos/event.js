window.TurboBoostEvents = { 'turbo-boost:streams:demo': [] }

window.addEventListener('turbo-boost:streams:demo', event => {
  if (event.target !== window) return
  console.log(
    'received the turbo-boost:streams:demo event',
    event.target,
    event
  )
  TurboBoostEvents[event.type].push(event)
})

document.addEventListener('turbo-boost:streams:demo', event => {
  console.log(
    'received the turbo-boost:streams:demo event',
    event.target,
    event
  )
  TurboBoostEvents[event.type].push(event)
})
