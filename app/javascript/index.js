import invoke from './invoke'

function initialize (streamActions) {
  streamActions.invoke = invoke
}

export default { initialize }
