import { regex } from 'vuelidate/lib/validators/common'

const clpRegexp = /^[A-Z]{1,2}\d{4,10}$/i

export default regex('licenseNumber', clpRegexp)
