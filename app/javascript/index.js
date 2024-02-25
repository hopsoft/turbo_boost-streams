import VERSION from './version'
import schema from './schema'
import morph from './morph'
import { invoke, invokeEvents } from './invoke'

if (!self['Turbo'])
  throw new Error(
    '`Turbo` is not defined! Be sure to import `@turbo-boost/streams` after `@hotwired/turbo` or `@hotwired/turbo-rails`.'
  )

if (!Turbo['StreamActions'])
  throw new Error(
    '`Turbo.StreamActions` is not defined! Verify that you are running >= `7.2.0` of `@hotwired/turbo`.'
  )

Turbo.StreamActions.invoke = invoke
self.TurboBoost = self.TurboBoost || {}
self.TurboBoost.Streams = { invoke, invokeEvents, morph, schema, VERSION }

console.info('@turbo-boost/streams has initialized and registered new stream actions with Turbo.')

export default self.TurboBoost.Streams
