import { regex } from 'vuelidate/lib/validators/common'

const fullNameRegexp = /^\s*[A-Z][,-.0-9A-Za-z]+(\s[A-Z][,-.0-9A-Za-z]+)+\s*$/

export default regex('fullName', fullNameRegexp)
