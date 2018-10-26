import { regex } from 'vuelidate/lib/validators/common'
import XRegExp from 'xregexp'

const companyNameRegexp = XRegExp('^\\s*[\\pL\\pN\\pP\\pS]+(\\s[\\pL\\pN\\pP\\pS]+)*\\s*$')

export default regex('companyName', companyNameRegexp)
