import { regex } from 'vuelidate/lib/validators/common'

const jobTitleRegexp = /^\s*[,-.0-9A-Za-z]+(\s[,-.0-9A-Za-z]+)*\s*$/

export default regex('jobTitle', jobTitleRegexp)
