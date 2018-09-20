import { helpers } from 'vuelidate/lib/validators'
import { isValidNumber } from '~/lib/phone-number'
import { withParams } from 'vuelidate'

export default withParams({ type: 'phone' }, (value) => !helpers.req(value) || isValidNumber(value))
