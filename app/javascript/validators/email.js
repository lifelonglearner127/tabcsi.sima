import { regex } from 'vuelidate/lib/validators/common'

const emailRegexp = new RegExp(
  "^ *(?=[!#$%&'*+./0-9=?@^_`a-z{|}~-]{5,192} *$)(?=[!#$%&'*+./0-9=?^_`a-z{|}~-]{1,64}@)[!#$%&'*+/0-9=?^_`a-z{|}~-]+" +
  "(?:\\.[!#$%&'*+/0-9=?^_`a-z{|}~-]+)*@(?:(?=[0-9a-z-]{1,63}\\.)[0-9a-z](?:[0-9a-z-]*[0-9a-z])?\\.)+" +
  '(?=[0-9a-z-]{1,63} *$)[0-9a-z](?:[0-9a-z-]*[0-9a-z])? *$',
  'i'
)

export default regex('email', emailRegexp)
