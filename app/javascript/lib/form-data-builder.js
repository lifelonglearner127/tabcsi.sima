import Builder from './builder'
import snakeCase from 'lodash/snakeCase'

// No inheritance because IE 10 does not support `__proto__`.
class FormDataBuilder {
  static build (data) {
    return Builder.build(new FormData(), data, snakeCase, (builtData, key, value) => {
      builtData.append(key, value)
    })
  }
}

export default FormDataBuilder
