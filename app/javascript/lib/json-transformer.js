import forEach from 'lodash/forEach'
import { isArrayLike } from './utils'
import isPlainObject from 'lodash/isPlainObject'
import mapKeys from 'lodash/mapKeys'
import snakeCase from 'lodash/snakeCase'

class JsonTransformer {
  static transform (data) {
    const transformedData = isArrayLike(data) ? this.transformArray(data) : this.transformObject(data)

    return JSON.stringify(transformedData)
  }

  static transformArray (array) {
    const self = this

    forEach(array, (value, index) => {
      if (isArrayLike(value)) {
        array[index] = self.transformArray(value)
      } else if (isPlainObject(value)) {
        array[index] = self.transformObject(value)
      }
    })

    return array
  }

  static transformObject (obj) {
    const self = this
    const transformedData = mapKeys(obj, (_value, key) => snakeCase(key))

    forEach(transformedData, (value, key) => {
      if (isArrayLike(value)) {
        transformedData[key] = self.transformArray(value)
      } else if (isPlainObject(value)) {
        transformedData[key] = self.transformObject(value)
      }
    })

    return transformedData
  }
}

export default JsonTransformer
