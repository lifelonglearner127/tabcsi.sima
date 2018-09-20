<script>
import { email, helpers, required } from 'vuelidate/lib/validators'
import isEmpty from 'lodash/isEmpty'
import NewUser from '~/components/new-user'
import PageMixin from '~/mixins/page'
import UsersSessionsContainer from '~/components/users-sessions-container'

const alpha = helpers.regex('alpha', (/^[a-zA-Z\s]+$/))

const usPhone = (value) => {
  if (isEmpty(value)) {
    return true
  }

  return (/^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/).test(value)
}

const licensePermitNumber = (value) => {
  if (isEmpty(value)) {
    return true
  }

  return (/^[A-Z]{1,2}\d{4,10}$/i).test(value)
}

export default {
  name: 'Users',

  components: {
    NewUser,
    UsersSessionsContainer
  },

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
      }
    }
  },

  validations: {
    user: {
      fullName: {
        required,
        alpha
      },
      email: {
        required,
        email
      },
      phone: {
        required,
        usPhone
      },
      companyName: { required },
      jobTitle: { required },
      licenseNumber: {
        required,
        licensePermitNumber
      }
    }
  },

  methods: {
    validateBeforeSubmit (e) {
      this.$refs.newUser.validateBeforeSubmit(e)
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
    :validation-method="validateBeforeSubmit"
    back-href="/"
    cols="12"
    show-back-button
    show-top-back-button
    sm="6"
    submit-text="Sign Up"
    text-class="font-italic"
    title="Create a New Account"
  >
    <new-user
      ref="newUser"
      is-sign-up
    >
    </new-user>
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
