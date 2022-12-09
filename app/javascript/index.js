import invoke from './invoke'

if (!Turbo)
  throw new Error(
    '`Turbo` is not defined! Be sure to import `turbo_ready` after `@hotwired/turbo` or `@hotwired/turbo-rails`.'
  )

if (!Turbo.StreamActions)
  throw new Error(
    '`Turbo.StreamActions` is not defined! Verify that you are running >= `7.2.0` of `@hotwired/turbo`.'
  )

Turbo.StreamActions.invoke = invoke
self.TurboReady = { StreamActions: { invoke } }

console.info(
  'TurboReady has initialized and has registered new stream actions with Turbo.'
)
