import { regex } from 'vuelidate/lib/validators/common'

const companyNameRegexp = /^\s*[A-Z][!&()+-;?-[\]a-z]+(\s[!&()+-;?-[\]a-z]+)*\s*$/

export default regex('companyName', companyNameRegexp)
