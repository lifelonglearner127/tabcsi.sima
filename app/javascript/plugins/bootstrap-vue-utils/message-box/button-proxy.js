import { BUTTON_HANDLER_NAMES } from './buttons'
import filter from 'lodash/filter'
import forEach from 'lodash/forEach'
import isFunction from 'lodash/isFunction'

export default class ButtonProxy {
  constructor () {
    this._handlers = {}

    this._defineMethods()
  }

  any (fn) {
    forEach(filter(BUTTON_HANDLER_NAMES, (name) => name !== 'error'), (name) => {
      this._setHandler(name, fn)
    })

    return this
  }

  callHandler (name, ...args) {
    const fn = this._handlers[name]

    if (fn) {
      fn(...args)
    }
  }

  _defineMethods () {
    forEach(BUTTON_HANDLER_NAMES, (name) => {
      this[name] = (fn) => {
        this._setHandler(name, fn)

        return this
      }
    })
  }

  _setHandler (name, fn) {
    if (!isFunction(fn)) {
      return
    }

    this._handlers[name] = fn
  }
}
