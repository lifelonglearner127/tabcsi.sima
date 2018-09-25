import endsWith from 'lodash/endsWith'
import forEach from 'lodash/forEach'
import { isArrayLike } from './utils'
import isPlainObject from 'lodash/isPlainObject'

const KEY_ARRAY_BRACKETS_OFFSET = -2

class Builder {
  constructor (data, keyTransformer, appender) {
    this._builtData = data
    this._keyTransformer = keyTransformer
    this._appender = appender
  }

  get appender () {
    return this._appender
  }

  get builtData () {
    return this._builtData
  }

  get keyTransformer () {
    return this._keyTransformer
  }

  static build (baseData, data, keyTransformer, appender) {
    const builder = new this(baseData, keyTransformer, appender)

    builder.appendObject(null, data)

    return builder.builtData
  }

  static makeObjectKey (keyTransformer, originalKey, namespace) {
    let key

    key = originalKey.trim()
    if (endsWith(key, '[]')) {
      key = key.slice(0, KEY_ARRAY_BRACKETS_OFFSET)
    }

    key = keyTransformer(key)

    if (namespace) {
      key = `${namespace}[${key}]`
    }

    return key
  }

  appendObject (namespace, obj) {
    const self = this

    forEach(obj, (value, k) => {
      // FormData serializes null as "null"; skip null values; the api will see nil since the key won't exist.
      if (value == null) {
        return
      }

      const key = self.constructor.makeObjectKey(self.keyTransformer, k, namespace)

      self.appendValue(key, value)
    })
  }

  appendArray (namespace, array) {
    const self = this
    const key = `${namespace}[]`

    forEach(array, (value) => {
      self.append(key, value)
    })
  }

  appendValue (key, value) {
    if (isArrayLike(value)) {
      this.appendArray(key, value)
    } else if (isPlainObject(value)) {
      this.appendObject(key, value)
    } else {
      this.append(key, value)
    }
  }

  append (key, value) {
    this.appender(this.builtData, key, value)
  }
}

export default Builder
