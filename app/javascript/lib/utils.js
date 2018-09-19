import includes from 'lodash/includes'
import isPlainObject from 'lodash/isPlainObject'
import map from 'lodash/map'
import mapKeys from 'lodash/mapKeys'
import mapValues from 'lodash/mapValues'
import Vue from 'vue'

export const debugLog = (...args) => {
  if (Vue.config.devtools) {
    console.log(...args) // eslint-disable-line no-console
  }
}

export const hasOwnProperty = (obj, key) => Object.prototype.hasOwnProperty.call(obj, key)

export const genEnumValidator = (values) => {
  const upcaseValues = map(values, (value) => value.toString().toUpperCase())

  return (value) => includes(upcaseValues, value.toUpperCase())
}

export const NO_PROMISE_RETURNED = null

export const noopPromiseHandler = () => NO_PROMISE_RETURNED

export const deepMapKeys = (object, iteratee) => mapKeys(
  mapValues(object, (v) => {
    if (isPlainObject(v)) {
      return deepMapKeys(v, iteratee)
    }

    if (Array.isArray(v)) {
      return map(v, (item) => deepMapKeys(item, iteratee))
    }

    return v
  }),
  iteratee
)
