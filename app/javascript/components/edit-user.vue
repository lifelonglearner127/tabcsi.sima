<script>
import { email, fullName, jobTitle, phone } from '~/validators'
import { AsYouType } from '~/lib/phone-number'
import compact from 'lodash/compact'
import map from 'lodash/map'
import { parseDigit } from '~/lib/utils'
import { required } from 'vuelidate/lib/validators'
import snakeCase from 'lodash/snakeCase'
import { titleizeValue } from '~/lib/formatters'
import ValidationMixin from '~/mixins/validation'

export default {
  name: 'EditUser',

  mixins: [ValidationMixin('user')],

  props: {
    hasLockedLocations: Boolean,
    isProfile: Boolean,
    locations: {
      type: Array,

      default () {
        return []
      }
    },
    loggedInUserIsTabc: Boolean,
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
          formatter: titleizeValue,
          icon: 'fas-fa-user',
          label: 'Full Name',
          required: true
        },
        email: {
          autoComplete: 'email',
          description: this.hasLockedLocations ? 'Email cannot be changed while there are pending reports.' : '',
          disabled: this.hasLockedLocations,
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
        jobTitle: {
          required,
          jobTitle
        },
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
          text: compact([location.name, this.locationAddress(location), location.clp]).join('<br>'),
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
    },

    showRoles () {
      return !this.isProfile && !this.loggedInUserIsTabc
    }
  },

  methods: {
    locationAddress (location) {
      return compact([
        location.address1,
        location.address2,
        location.address3,
        compact([
          location.city,
          location.county,
          location.state,
          location.postalCode
        ]).join(' '),
        location.country
      ]).join(', ')
    },

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
      id="user_profile"
      name="user[profile]"
      type="hidden"
      :value="isProfile"
    >
    <template v-for="(options, key) in form">
      <b-form-group
        v-if="options.show == null ? true : options.show"
        :id="inputGroupId(key)"
        :key="key"
        :data-required="options.required"
        :invalid-feedback="invalidFeedback(key)"
        :label="options.label"
        :label-for="inputId(key)"
        :state="state(key)"
      >
        <b-input-group>
          <b-input-group-prepend is-text>
            <fa-sprite
              fixed-width
              :use="options.icon"
            />
          </b-input-group-prepend>
          <component
            :is="options.component || 'b-form-input'"
            :id="inputId(key)"
            v-model="$v.user[key].$model"
            :autocomplete="options.autoComplete"
            class="form-control"
            :data-path="key"
            :disabled="options.disabled"
            :format="options.format"
            :formatter="options.formatter"
            :maxlength="options.maxLength"
            :name="inputName(key)"
            :parse="options.parse"
            :placeholder="options.placeholder"
            :required="options.required"
            :type="options.type || 'text'"
            @blur.native="validate"
            @input.native="validate"
          />
        </b-input-group>
        <span
          slot="description"
          class="text-danger"
        >
          {{ options.description }}
        </span>
      </b-form-group>
    </template>

    <template v-if="showRoles">
      <b-form-group
        id="user_role_group"
        data-required
        :invalid-feedback="invalidFeedback('role')"
        label="Role"
        label-for="user_role"
        :state="state('role')"
      >
        <b-form-radio-group
          id="user_role"
          v-model="$v.user.role.$model"
          data-path="role"
          name="user[role]"
          :options="roles"
          required
          @change="validate"
        />
      </b-form-group>

      <b-form-group
        v-show="isUser"
        id="user_location_clps_group"
        :data-required="isUser"
        :invalid-feedback="invalidFeedback('locationClps')"
        label="Locations"
        label-for="user_location_clps"
        :state="state('locationClps')"
      >
        <b-form-checkbox-group
          id="user_location_clps"
          v-model="$v.user.locationClps.$model"
          data-path="locationClps"
          name="user[location_clps][]"
          :options="locationClps"
          :required="isUser"
          stacked
          @change="validate"
        />
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
