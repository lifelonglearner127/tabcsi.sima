<script>
import PageMixin from '~/mixins/page'
import snakeCase from 'lodash/snakeCase'
import UsersSessionsContainer from '~/components/users-sessions-container'

export default {
  name: 'Users',

  components: { UsersSessionsContainer },

  mixins: [PageMixin],

  data () {
    return {
      user: {
        companyName: '',
        email: '',
        fullName: '',
        jobTitle: '',
        licenseNumber: '',
        phone: ''
      },
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
          required: true,
          type: 'email'
        },
        phone: {
          autoComplete: 'tel',
          icon: 'fas-fa-phone',
          label: 'Phone Number',
          required: true,
          type: 'tel'
        },
        companyName: {
          autoComplete: 'organization',
          icon: 'fas-fa-industry',
          label: 'Company Name',
          required: true
        },
        jobTitle: {
          autoComplete: 'organization-title',
          icon: 'fas-fa-user-tie',
          label: 'Job Title',
          required: true
        },
        licenseNumber: {
          autoComplete: 'off',
          icon: 'fas-fa-id-card',
          label: 'License/Permit Number',
          required: true
        }
      }
    }
  },

  methods: {
    inputGroupId (key) {
      return `${this.inputId(key)}_group`
    },

    inputId (key) {
      return `user_${snakeCase(key)}`
    },

    inputName (key) {
      return `user[${snakeCase(key)}]`
    }
  }
}
</script>

<template>
  <users-sessions-container
    :accept-charset="acceptCharset"
    :action="action"
    :enforce-utf8="enforceUtf8"
    :hidden-method="hiddenMethod"
    :method="method"
    :token-name="tokenName"
    :token-value="tokenValue"
    cols="12"
    sm="6"
    submit-text="Sign Up"
    text-class="font-italic"
    title="Create a New Account"
  >
    <b-form-group
      v-for="(options, key) in form"
      :id="inputGroupId(key)"
      :key="key"
      :label="options.label"
      :label-for="inputId(key)"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            :use="options.icon"
            no-wrapper
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          v-model="user[key]"
          :autocomplete="options.autoComplete"
          :id="inputId(key)"
          :name="inputName(key)"
          :required="options.required"
          :type="options.type || 'text'"
        >
        </b-form-input>
      </b-input-group>
    </b-form-group>

    <b-form-text class="font-italic">
      <fa-sprite use="fas-fa-info-circle"></fa-sprite> Enter one of the license/permit numbers you are managing. For
      example: <strong>MB1234567</strong>. You will be assigned licenses/permits that are associated with this once you
      log in into the system.
    </b-form-text>
  </users-sessions-container>
</template>

<style lang="scss" scoped>
.fa-phone {
  filter: fliph;
  transform: scaleX(-1);
}

.form-text {
  text-align: left;
}
</style>
