import { regex } from 'vuelidate/lib/validators/common'
import XRegExp from 'xregexp'

const jobTitleRegexp = XRegExp('^\\s*[,.\\pL\\p{Nd}\\p{Nl}\\p{Pd}]+(\\s[,.\\pL\\p{Nd}\\p{Nl}\\p{Pd}]+)*\\s*$')

export default regex('jobTitle', jobTitleRegexp)
