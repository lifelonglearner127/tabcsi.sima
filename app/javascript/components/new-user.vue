<script>
import { companyName, email, fullName, jobTitle, licenseNumber, phone } from '~/validators'
import { AsYouType } from '~/lib/phone-number'
import compact from 'lodash/compact'
import map from 'lodash/map'
import { parseDigit } from '~/lib/utils'
import { required } from 'vuelidate/lib/validators'
import snakeCase from 'lodash/snakeCase'
import { titleizeValue } from '~/lib/formatters'
import ValidationMixin from '~/mixins/validation'

export default {
  name: 'NewUser',

  mixins: [ValidationMixin('user')],

  props: {
    isInvite: Boolean,
    locations: {
      type: Array,

      default () {
        return []
      }
    },
    ownerName: {
      type: String,
      default: ''
    },
    user: {
      type: Object,

      default () {
        return {
          companyName: '',
          email: '',
          fullName: '',
          jobTitle: '',
          licenseNumber: '',
          locationClps: [],
          phone: '',
          role: 'user'
        }
      }
    },
    byWhom: {
      type: Object,
      default: null
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
          formatter: titleizeValue,
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
        jobTitle: {
          required,
          jobTitle
        },
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
      schema.user.companyName = {
        required,
        companyName
      }

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
    <template v-if="isInvite">
      <input
        id="user_invited"
        name="user[invited]"
        type="hidden"
        value="true"
      >
      <input
        id="user_by_whom_id"
        name="user[by_whom_id]"
        type="hidden"
        :value="byWhom.id"
      >
      <input
        id="user_owner_name"
        name="user[owner_name]"
        type="hidden"
        :value="ownerName"
      >
    </template>
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
            :class="{ 'form-control': options.component }"
            :data-path="key"
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
      </b-form-group>
    </template>

    <b-form-text
      v-if="!isInvite"
      class="font-italic"
    >
      <fa-sprite
        fixed-width
        use="fas-fa-info-circle"
      />
      Enter one of the license/permit numbers you are managing. For
      example: <strong>MB1234567</strong>. You will be assigned licenses/permits that are associated with this once you
      log in into the system.
    </b-form-text>

    <template v-if="isInvite">
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
