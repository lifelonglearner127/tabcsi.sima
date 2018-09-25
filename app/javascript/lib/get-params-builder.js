import Builder from './builder'
import snakeCase from 'lodash/snakeCase'

// No inheritance because IE 10 does not support `__proto__`.
class GetParamsBuilder {
  static build (data) {
    return Builder.build({}, data, snakeCase, (builtData, key, value) => {
      builtData[key] = value
    })
  }
}

export default GetParamsBuilder
