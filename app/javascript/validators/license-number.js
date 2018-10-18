import { regex } from 'vuelidate/lib/validators/common'

const clpRegexp = /^\s*[A-Z]{1,2}\s*\d{4,10}\s*$/i

export default regex('licenseNumber', clpRegexp)
