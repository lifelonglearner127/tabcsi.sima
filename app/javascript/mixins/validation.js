import { ensureDebounceFunc } from '~/lib/utils'
import get from 'lodash/get'
import { getMessage } from '~/validators'

const DEBOUNCE_DELAY = 250 // milliseconds

// @vue/component
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
      const object = this.$v[this.validationKey]

      return get(object, path)
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
      const target = event.target

      if (!target) {
        return
      }

      const path = target.dataset.path
      const field = this.getValidationField(path)

      if (!field) {
        return
      }

      field.$touch()
    }
  }
})
