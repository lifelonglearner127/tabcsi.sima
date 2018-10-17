// Action Cable provides the framework to deal with WebSockets in Rails. You can generate new channels where WebSocket
// features live using the `rails generate channel` command.

import ActionCable from 'actioncable'

const isDev = process.env.NODE_ENV === 'development'
const enableDebugging = isDev && false

if (enableDebugging) {
  ActionCable.startDebugging()
}

export const logger = (...messages) => {
  if (enableDebugging) {
    ActionCable.log(...messages)
  } else if (isDev) {
    ActionCable.logger.log(...messages)
  }
}

export default ActionCable.createConsumer()
