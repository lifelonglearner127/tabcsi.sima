<script>
import { email, fullName, licenseNumber, phone } from '~/validators'
import { AsYouType } from '~/lib/phone-number'
import map from 'lodash/map'
import { parseDigit } from '~/lib/utils'
import { required } from 'vuelidate/lib/validators'
import snakeCase from 'lodash/snakeCase'
import ValidationMixin from '~/mixins/validation'

export default {
  name: 'NewUser',

  mixins: [ValidationMixin('user')],

  props: {
    isInvite: {
      type: Boolean,
      default: false
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
        phone: '',
        role: 'user'
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
          required: true
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
          required: !this.isInvite,
          type: 'tel'
        },
        companyName: {
          autoComplete: 'organization',
          icon: 'fas-fa-industry',
          label: 'Company Name',
          placeholder: 'Awesome Food LLC',
          required: true,
          show: !this.isInvite
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
          show: !this.isInvite
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

    if (this.isInvite) {
      delete schema.user.phone.required

      schema.user.role = { required }

      schema.user.locationClps = {}
      if (this.isUser) {
        schema.user.locationClps.required = required
      }
    } else {
      schema.user.companyName = { required }
      schema.user.licenseNumber = {
        required,
        licenseNumber
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
    <template v-if="isInvite">
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
            :class="{ 'form-control': options.component }"
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
            @blur.native="validate"
            @input.native="validate"
          >
          </component>
        </b-input-group>
      </b-form-group>
    </template>

    <b-form-text
      v-if="!isInvite"
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

    <template v-if="isInvite">
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
