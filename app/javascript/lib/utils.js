import includes from 'lodash/includes'
import map from 'lodash/map'
import toUpper from 'lodash/toUpper'
import Vue from 'vue'

export const debugLog = (...args) => {
  if (Vue.config.devtools) {
    console.log(...args) // eslint-disable-line no-console
  }
}

export const hasOwnProperty = (obj, key) => Object.prototype.hasOwnProperty.call(obj, key)

export const genEnumValidator = (values) => {
  const upcaseValues = map(values, (value) => toUpper(value.toString()))

  return (value) => includes(upcaseValues, toUpper(value))
}

export const NO_PROMISE_RETURNED = null

export const noopPromiseHandler = () => NO_PROMISE_RETURNED
