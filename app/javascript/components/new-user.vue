<script>
import { email, fullName, getMessage, licenseNumber, phone } from '~/validators'
import { ensureDebounceFunc, parseDigit } from '~/lib/utils'
import { AsYouType } from '~/lib/phone-number'
import get from 'lodash/get'
import map from 'lodash/map'
import { required } from 'vuelidate/lib/validators'
import snakeCase from 'lodash/snakeCase'

const DEBOUNCE_DELAY = 250 // milliseconds

export default {
  name: 'NewUser',

  props: {
    isSignUp: {
      type: Boolean,
      default: true
    },

    locations: {
      type: Array,

      default () {
        return []
      }
    },

    ownerName: {
      type: String,
      default: ''
    }
  },

  data () {
    return {
      user: {
        companyName: '',
        email: '',
        fullName: '',
        jobTitle: '',
        licenseNumber: '',
        locationClps: [],
        phone: ''
      },
      form: {
        fullName: {
          autoComplete: 'name',
          icon: 'fas-fa-user',
          label: 'Full Name',
          placeholder: 'John Smith',
          required: true
        },
        email: {
          autoComplete: 'email',
          icon: 'fas-fa-envelope',
          label: 'E-mail',
          maxLength: 192,
          placeholder: 'jsmith@example.com',
          required: true,
          type: 'email'
        },
        phone: {
          autoComplete: 'tel',
          component: 'vue-input',
          format: this.formatPhone,
          icon: 'fas-fa-phone',
          label: 'Phone Number',
          maxLength: 14,
          parse: this.parsePhone,
          placeholder: '(123) 456-7890',
          required: this.isSignUp,
          type: 'tel'
        },
        companyName: {
          autoComplete: 'organization',
          icon: 'fas-fa-industry',
          label: 'Company Name',
          placeholder: 'Awesome Food LLC',
          required: true,
          show: this.isSignUp
        },
        jobTitle: {
          autoComplete: 'organization-title',
          icon: 'fas-fa-user-tie',
          label: 'Job Title',
          placeholder: 'Owner',
          required: true
        },
        licenseNumber: {
          autoComplete: 'off',
          icon: 'fas-fa-id-card',
          label: 'License/Permit Number',
          placeholder: 'AB123456',
          required: true,
          show: this.isSignUp
        }
      }
    }
  },

  validations () {
    const schema = {
      user: {
        email: {
          required,
          email
        },
        fullName: {
          required,
          fullName
        },
        jobTitle: { required },
        phone: {
          required,
          phone
        }
      }
    }

    if (this.isSignUp) {
      schema.user.companyName = { required }
      schema.user.licenseNumber = {
        required,
        licenseNumber
      }
    } else {
      delete schema.user.phone.required

      schema.user.locationClps = { required }
    }

    return schema
  },

  computed: {
    locationClps () {
      return map(
        this.locations,
        (location) => ({
          text: `${location.name} (${location.clp})`,
          value: location.clp
        })
      )
    },

    submittable () {
      return !this.$v.$invalid
    }
  },

  methods: {
    formatPhone (value) {
      const asYouType = new AsYouType()
      const text = asYouType.input(value)
      const template = asYouType.template

      return {
        text, template
      }
    },

    getValidationField (path) {
      return get(this.$v.user, path)
    },

    inputGroupId (key) {
      return `${this.inputId(key)}_group`
    },

    inputId (key) {
      return `user_${snakeCase(key)}`
    },

    inputName (key) {
      return `user[${snakeCase(key)}]`
    },

    invalidFeedback (path) {
      return getMessage(this.getValidationField(path), this.state(path))
    },

    parsePhone (ch) {
      return parseDigit(ch)
    },

    state (path) {
      const field = this.getValidationField(path)

      return field ? !field.$error : true
    },

    validate (e) {
      const func = ensureDebounceFunc('validateDebounceFunc', this, this.validateDebounced, DEBOUNCE_DELAY)

      func(e)
    },

    validateLocationClps () {
      const func = ensureDebounceFunc(
        'validateLocationClpsDebounceFunc', this, this.validateLocationClpsDebounced, DEBOUNCE_DELAY
      )

      func()
    },

    validateBeforeSubmit () {
      this.$v.$touch()

      return this.submittable
    },

    validateDebounced (event) {
      const path = event.target.dataset.path
      const field = this.getValidationField(path)

      field.$touch()
    },

    validateLocationClpsDebounced () {
      this.$v.user.locationClps.$touch()
    }
  }
}
</script>

<template>
  <div>
    <template v-if="!isSignUp">
      <input
        id="user_is_invite"
        name="user[is_invite]"
        type="hidden"
        value="true"
      >
      <input
        id="user_owner_name"
        :value="ownerName"
        name="user[owner_name]"
        type="hidden"
      >
    </template>

    <template v-for="(options, key) in form">
      <b-form-group
        v-if="options.show == null ? true : options.show"
        :data-required="options.required"
        :id="inputGroupId(key)"
        :invalid-feedback="invalidFeedback(key)"
        :key="key"
        :label="options.label"
        :label-for="inputId(key)"
        :state="state(key)"
      >
        <b-input-group>
          <b-input-group-prepend is-text>
            <fa-sprite
              :use="options.icon"
              fixed-width
            >
            </fa-sprite>
          </b-input-group-prepend>
          <component
            v-model="$v.user[key].$model"
            :autocomplete="options.autoComplete"
            :data-path="key"
            :format="options.format"
            :id="inputId(key)"
            :is="options.component || 'b-form-input'"
            :maxlength="options.maxLength"
            :name="inputName(key)"
            :parse="options.parse"
            :placeholder="options.placeholder"
            :required="options.required"
            :type="options.type || 'text'"
            class="form-control"
            @blur.native="validate"
            @input.native="validate"
          >
          </component>
        </b-input-group>
      </b-form-group>
    </template>

    <b-form-text
      v-if="isSignUp"
      class="font-italic"
    >
      <fa-sprite
        fixed-width
        use="fas-fa-info-circle"
      >
      </fa-sprite>
      Enter one of the license/permit numbers you are managing. For
      example: <strong>MB1234567</strong>. You will be assigned licenses/permits that are associated with this once you
      log in into the system.
    </b-form-text>

    <b-form-group
      v-if="!isSignUp"
      id="user_location_clps_group"
      :invalid-feedback="invalidFeedback('locationClps')"
      :state="state('locationClps')"
      data-required
      label="Locations"
      label-for="user_location_clps"
    >
      <b-form-checkbox-group
        id="user_location_clps"
        v-model="$v.user.locationClps.$model"
        :options="locationClps"
        name="user[location_clps][]"
        required
        stacked
        @change="validateLocationClps"
      >
      </b-form-checkbox-group>
    </b-form-group>
  </div>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.fa-phone {
  filter: fliph;
  transform: scaleX(-1);
}

.form-text {
  text-align: left;
}

.form-group {
  &[data-required] {
    /deep/ .col-form-label::after {
      color: $danger;
      content: '*';
      margin-left: 0.25rem;
    }
  }
}

.custom-controls-stacked {
  border: $input-border-width solid $input-border-color;
  border-radius: $input-border-radius;
  height: 9.1rem;
  overflow: auto;
  padding: 0 0.25rem;
}
</style>
