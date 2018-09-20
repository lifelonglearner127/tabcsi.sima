import { regex } from 'vuelidate/lib/validators/common'

const fullNameRegexp = /^[^\s]+(\s[^\s]+)+$/

export default regex('fullName', fullNameRegexp)
