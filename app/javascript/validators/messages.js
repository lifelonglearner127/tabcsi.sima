import constant from 'lodash/constant'
import forEach from 'lodash/forEach'

const MESSAGES = {
  email: constant('Must be a valid email address.'),

  exactLength (params) {
    return `Must be exactly ${params.length} characters.`
  },

  fullName: constant('Must have both first and last name.'),

  licenseNumber: constant('Must be a valid license/permit number.'),

  maxLength (params) {
    return `Cannot be longer than ${params.max} characters.`
  },

  minLength (params) {
    const min = params.min

    return `Cannot have fewer than ${min} ${min === 1 ? 'item' : 'items'}.`
  },

  phone: constant('Must be a valid US telephone number.'),
  required: constant('Field is required.')
}

const _getMessage = (key, params) => {
  const messageFunc = MESSAGES[key]

  return messageFunc ? messageFunc(params) : 'Field is invalid.'
}

export default (field, state) => {
  let message

  message = undefined
  forEach(field, (flag, key) => {
    const params = field.$params[key]

    if (message || flag || !params) {
      return
    }

    message = _getMessage(key, params)
  })

  return state ? '' : message
}
