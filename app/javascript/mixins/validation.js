import { ensureDebounceFunc } from '~/lib/utils'
import get from 'lodash/get'
import { getMessage } from '~/validators'

const DEBOUNCE_DELAY = 250 // milliseconds

export default (validationKey) => ({
  data () {
    return { validationKey }
  },

  computed: {
    submittable () {
      return !this.$v.$invalid
    }
  },

  methods: {
    getValidationField (path) {
      return get(this.$v[this.validationKey], path)
    },

    invalidFeedback (path) {
      return getMessage(this.getValidationField(path), this.state(path))
    },

    state (path) {
      const field = this.getValidationField(path)

      return field ? !field.$error : true
    },

    validate (e) {
      const func = ensureDebounceFunc('validateDebounceFunc', this, this.validateDebounced, DEBOUNCE_DELAY)

      func(e)
    },

    validateBeforeSubmit () {
      this.$v.$touch()

      return this.submittable
    },

    validateDebounced (event) {
      const path = event.target.dataset.path
      const field = this.getValidationField(path)

      field.$touch()
    }
  }
})
