import { len, req } from 'vuelidate/lib/validators/common'
import { withParams } from 'vuelidate'

export default (length) => withParams(
  {
    type: 'exactLength',
    length
  },
  (value) => !req(value) || len(value) === length
)
