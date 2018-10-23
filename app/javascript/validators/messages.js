import constant from 'lodash/constant'
import forEach from 'lodash/forEach'

const MESSAGES = {
  companyName: constant('Must be a valid company name.'),
  email: constant('Must be a valid email address.'),

  exactLength (params) {
    return `Must be exactly ${params.length} characters.`
  },

  fullName: constant('Must be a valid full name.'),
  jobTitle: constant('Must be a valid job title.'),
  licenseNumber: constant('Must be a valid license/permit number.'),

  maxLength (params) {
    return `Cannot be longer than ${params.max} characters.`
  },

  minLength (params) {
    const min = params.min

    return `Must have at least ${min} ${min === 1 ? 'item' : 'items'}.`
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

  if (field) {
    forEach(field, (flag, key) => {
      const params = field.$params[key]

      if (message || flag || !params) {
        return
      }

      message = _getMessage(key, params)
    })
  }

  return state ? '' : message
}
