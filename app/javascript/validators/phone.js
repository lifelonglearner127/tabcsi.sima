import { isValidNumber } from '~/lib/phone-number'
import { withParams } from 'vuelidate'

export default withParams({ type: 'phone' }, isValidNumber)
