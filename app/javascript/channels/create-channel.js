import consumer, { logger } from './cable-consumer'
import assign from 'lodash/assign'
import camelCase from 'lodash/camelCase'
import upperFirst from 'lodash/upperFirst'

export default (name, typeMap, options = null) => {
  const cableName = camelCase(name)
  const params = { channel: `${upperFirst(cableName)}Channel` }

  if (options) {
    assign(params, options)
  }

  return consumer.subscriptions.create(params, {
    connected () {
      this._connected = true

      logger(`cable (${cableName}): connected`)
    },

    disconnected () {
      if (!this._connected) {
        return
      }

      this._connected = false

      logger(`cable (${cableName}): disconnected`)
    },

    received (data) {
      const typeFunc = typeMap[data.type]

      if (!typeFunc) {
        logger(`cable (${cableName}): Unknown message type:`, data.type)

        return
      }

      typeFunc(data)
    }
  })
}
