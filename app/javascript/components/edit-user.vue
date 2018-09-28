<script>
import { email, fullName, phone } from '~/validators'
import { AsYouType } from '~/lib/phone-number'
import map from 'lodash/map'
import { parseDigit } from '~/lib/utils'
import { required } from 'vuelidate/lib/validators'
import snakeCase from 'lodash/snakeCase'
import ValidationMixin from '~/mixins/validation'

export default {
  name: 'EditUser',

  mixins: [ValidationMixin('user')],

  props: {
    isProfile: {
      type: Boolean,
      default: false
    },
    locations: {
      type: Array,

      default () {
        return []
      }
    },
    user: {
      type: Object,
      required: true
    }
  },

  data () {
    return {
      form: {
        fullName: {
          autoComplete: 'name',
          icon: 'fas-fa-user',
          label: 'Full Name',
          required: true
        },
        email: {
          autoComplete: 'email',
          icon: 'fas-fa-envelope',
          label: 'E-mail',
          maxLength: 192,
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
          type: 'tel'
        },
        jobTitle: {
          autoComplete: 'organization-title',
          icon: 'fas-fa-user-tie',
          label: 'Job Title',
          required: true
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
        phone: { phone }
      }
    }

    if (!this.isProfile) {
      schema.user.role = { required }

      schema.user.locationClps = {}
      if (this.isUser) {
        schema.user.locationClps.required = required
      }
    }

    return schema
  },

  computed: {
    isUser () {
      return this.user.role === 'user'
    },

    locationClps () {
      return map(
        this.locations,
        (location) => ({
          text: `${location.name} (${location.clp})`,
          value: location.clp
        })
      )
    },

    roles () {
      return [
        {
          text: 'User',
          value: 'user'
        },
        {
          text: 'Admin',
          value: 'admin'
        }
      ]
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

    inputGroupId (key) {
      return `${this.inputId(key)}_group`
    },

    inputId (key) {
      return `user_${snakeCase(key)}`
    },

    inputName (key) {
      return `user[${snakeCase(key)}]`
    },

    parsePhone (ch) {
      return parseDigit(ch)
    }
  }
}
</script>

<template>
  <div>
    <input
      id="user_edited"
      name="user[edited]"
      type="hidden"
      value="true"
    >
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

    <template v-if="!isProfile">
      <b-form-group
        id="user_role_group"
        :invalid-feedback="invalidFeedback('role')"
        :state="state('role')"
        data-required
        label="Role"
        label-for="user_role"
      >
        <b-form-radio-group
          id="user_role"
          v-model="$v.user.role.$model"
          :options="roles"
          data-path="role"
          name="user[role]"
          required
          @change="validate"
        >
        </b-form-radio-group>
      </b-form-group>

      <b-form-group
        v-show="isUser"
        id="user_location_clps_group"
        :data-required="isUser"
        :invalid-feedback="invalidFeedback('locationClps')"
        :state="state('locationClps')"
        label="Locations"
        label-for="user_location_clps"
      >
        <b-form-checkbox-group
          id="user_location_clps"
          v-model="$v.user.locationClps.$model"
          :options="locationClps"
          :required="isUser"
          data-path="locationClps"
          name="user[location_clps][]"
          stacked
          @change="validate"
        >
        </b-form-checkbox-group>
      </b-form-group>
    </template>
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

.custom-controls-stacked {
  border: $input-border-width solid $input-border-color;
  border-radius: $input-border-radius;
  height: 9.1rem;
  overflow: auto;
  padding: 0 0.25rem;
}
</style>
