import _isArrayLike from 'lodash/isArrayLike'
import debounce from 'lodash/debounce'
import includes from 'lodash/includes'
import isPlainObject from 'lodash/isPlainObject'
import isString from 'lodash/isString'
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

export const isArrayLike = (value) => _isArrayLike(value) && !isString(value)

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

const debounceFuncs = {}

export const ensureDebounceFunc = (key, ctx, fn, wait) => {
  if (!debounceFuncs[key]) {
    debounceFuncs[key] = debounce(fn, wait).bind(ctx)
  }

  return debounceFuncs[key]
}

const DIGITS = {
  0: '0',
  1: '1',
  2: '2',
  3: '3',
  4: '4',
  5: '5',
  6: '6',
  7: '7',
  8: '8',
  9: '9',
  '\u0660': '0', // Arabic-indic digit 0
  '\u0661': '1', // Arabic-indic digit 1
  '\u0662': '2', // Arabic-indic digit 2
  '\u0663': '3', // Arabic-indic digit 3
  '\u0664': '4', // Arabic-indic digit 4
  '\u0665': '5', // Arabic-indic digit 5
  '\u0666': '6', // Arabic-indic digit 6
  '\u0667': '7', // Arabic-indic digit 7
  '\u0668': '8', // Arabic-indic digit 8
  '\u0669': '9', // Arabic-indic digit 9
  '\u06F0': '0', // Eastern-Arabic digit 0
  '\u06F1': '1', // Eastern-Arabic digit 1
  '\u06F2': '2', // Eastern-Arabic digit 2
  '\u06F3': '3', // Eastern-Arabic digit 3
  '\u06F4': '4', // Eastern-Arabic digit 4
  '\u06F5': '5', // Eastern-Arabic digit 5
  '\u06F6': '6', // Eastern-Arabic digit 6
  '\u06F7': '7', // Eastern-Arabic digit 7
  '\u06F8': '8', // Eastern-Arabic digit 8
  '\u06F9': '9', // Eastern-Arabic digit 9
  '\uFF10': '0', // Fullwidth digit 0
  '\uFF11': '1', // Fullwidth digit 1
  '\uFF12': '2', // Fullwidth digit 2
  '\uFF13': '3', // Fullwidth digit 3
  '\uFF14': '4', // Fullwidth digit 4
  '\uFF15': '5', // Fullwidth digit 5
  '\uFF16': '6', // Fullwidth digit 6
  '\uFF17': '7', // Fullwidth digit 7
  '\uFF18': '8', // Fullwidth digit 8
  '\uFF19': '9' // Fullwidth digit 9
}

export const parseDigit = (ch) => DIGITS[ch]
