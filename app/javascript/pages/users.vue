<script>
import { email, helpers, required } from 'vuelidate/lib/validators'
import PageMixin from '~/mixins/page'
import UsersSessionsContainer from '~/components/users-sessions-container'

const alpha = helpers.regex('alpha', (/^[a-zA-Z\s]+$/))
const USPhone = (value) => {
  if (value === null || value === '') {
    return true
  }

  return (/^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/).test(value)
}

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
        USPhone
      },
      companyName: { required },
      jobTitle: { required },
      licenseNumber: { required }
    }
  },

  methods: {
    validateBeforeSubmit (e) {
      this.$v.$touch()
      if (!this.$v.$invalid) {
        e.target.submit()
      }
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
    cols="12"
    sm="6"
    submit-text="Sign Up"
    text-class="font-italic"
    title="Create a New Account"
  >
    <!-- Full Name -->
    <b-form-group
      id="user_full_name_group"
      label="Full Name"
      label-for="user_full_name"

    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-user"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          id="user_full_name"
          v-model="$v.user.fullName.$model"
          :class="{ 'is-invalid': $v.user.fullName.$error }"
          autocomplete="name"
          name="user[full_name]"
          placeholder="John Smith"
          type="text"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback
        v-if="$v.user.fullName.$error && !$v.user.fullName.required"
        class="d-block"
      >
        Full Name is required.
      </b-form-feedback>
      <b-form-feedback
        v-if="$v.user.fullName.$error && !$v.user.fullName.alpha"
        class="d-block"
      >
        Please enter only characters.
      </b-form-feedback>
    </b-form-group>

    <!-- Email -->
    <b-form-group
      id="user_email_group"
      label="E-mail"
      label-for="user_email"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-envelope"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          id="user_email"
          v-model="$v.user.email.$model"
          :class="{ 'is-invalid': $v.user.email.$error }"
          autocomplete="email"
          name="user[email]"
          placeholder="jsmith@example.com"
          type="email"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback
        v-if="$v.user.email.$error && !$v.user.email.required"
        class="d-block"
      >
        Email is required.
      </b-form-feedback>
      <b-form-feedback
        v-if="$v.user.email.$error && !$v.user.email.email"
        class="d-block"
      >
        Please enter a valid email address.
      </b-form-feedback>
    </b-form-group>

    <!-- Phone Number -->
    <b-form-group
      id="user_phone_group"
      label="Phone Number"
      label-for="user_phone"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-phone"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          id="user_phone"
          v-model="$v.user.phone.$model"
          :class="{ 'is-invalid': $v.user.phone.$error }"
          autocomplete="tel"
          name="user[phone]"
          placeholder="(123) 456-7890"
          type="text"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback
        v-if="$v.user.phone.$error && !$v.user.phone.required"
        class="d-block"
      >
        Phone Number is required.
      </b-form-feedback>
      <b-form-feedback
        v-if="$v.user.phone.$error && !$v.user.phone.USPhone"
        class="d-block"
      >
        Please enter a valid format phone number.
      </b-form-feedback>
    </b-form-group>

    <!-- Company Name -->
    <b-form-group
      id="user_company_name_group"
      label="Company Name"
      label-for="user_company_name"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-industry"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          id="user_company_name"
          v-model="$v.user.companyName.$model"
          :class="{ 'is-invalid': $v.user.companyName.$error }"
          autocomplete="organization"
          name="user[company_name]"
          placeholder="Awesome Food LLC"
          type="text"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback
        v-if="$v.user.companyName.$error"
        class="d-block"
      >
        Company Name is required.
      </b-form-feedback>
    </b-form-group>

    <!-- Job Title -->
    <b-form-group
      id="user_job_title_group"
      label="Job Title"
      label-for="user_job_title"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-user-tie"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          id="user_job_title"
          v-model="$v.user.jobTitle.$model"
          :class="{ 'is-invalid': $v.user.jobTitle.$error }"
          autocomplete="organization-title"
          name="user[job_title]"
          placeholder="Owner"
          type="text"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback
        v-if="$v.user.jobTitle.$error"
        class="d-block"
      >
        Job Title is required.
      </b-form-feedback>
    </b-form-group>

    <!-- License/Permit Number -->
    <b-form-group
      id="user_license_number_group"
      label="License/Permit Number"
      label-for="user_license_number"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-user-tie"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          id="user_license_number"
          v-model="$v.user.licenseNumber.$model"
          :class="{ 'is-invalid': $v.user.licenseNumber.$error }"
          autocomplete="off"
          name="user[license_number]"
          placeholder="AB123456"
          type="text"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback
        v-if="$v.user.licenseNumber.$error"
        class="d-block"
      >
        License/Permit Number is required.
      </b-form-feedback>
    </b-form-group>

    <b-form-text class="font-italic">
      <fa-sprite
        fixed-width
        use="fas-fa-info-circle"
      >
      </fa-sprite>
      Enter one of the license/permit numbers you are managing. For
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
